:- dynamic(matches/4).

% matches(Type, Dimension, Direction, yes)
% If a personality Type supports a given Dimension + Direction

% =========================
% INTJ
% =========================
matches(intj, ei, i, yes).
matches(intj, sn, n, yes).
matches(intj, tf, t, yes).
matches(intj, jp, j, yes).

% =========================
% INTP
% =========================
matches(intp, ei, i, yes).
matches(intp, sn, n, yes).
matches(intp, tf, t, yes).
matches(intp, jp, p, yes).

% =========================
% ENTJ
% =========================
matches(entj, ei, e, yes).
matches(entj, sn, n, yes).
matches(entj, tf, t, yes).
matches(entj, jp, j, yes).

% =========================
% ENTP
% =========================
matches(entp, ei, e, yes).
matches(entp, sn, n, yes).
matches(entp, tf, t, yes).
matches(entp, jp, p, yes).

% =========================
% INFJ
% =========================
matches(infj, ei, i, yes).
matches(infj, sn, n, yes).
matches(infj, tf, f, yes).
matches(infj, jp, j, yes).

% =========================
% INFP
% =========================
matches(infp, ei, i, yes).
matches(infp, sn, n, yes).
matches(infp, tf, f, yes).
matches(infp, jp, p, yes).

% =========================
% ENFJ
% =========================
matches(enfj, ei, e, yes).
matches(enfj, sn, n, yes).
matches(enfj, tf, f, yes).
matches(enfj, jp, j, yes).

% =========================
% ENFP
% =========================
matches(enfp, ei, e, yes).
matches(enfp, sn, n, yes).
matches(enfp, tf, f, yes).
matches(enfp, jp, p, yes).

% =========================
% ISTJ
% =========================
matches(istj, ei, i, yes).
matches(istj, sn, s, yes).
matches(istj, tf, t, yes).
matches(istj, jp, j, yes).

% =========================
% ISFJ
% =========================
matches(isfj, ei, i, yes).
matches(isfj, sn, s, yes).
matches(isfj, tf, f, yes).
matches(isfj, jp, j, yes).

% =========================
% ESTJ
% =========================
matches(estj, ei, e, yes).
matches(estj, sn, s, yes).
matches(estj, tf, t, yes).
matches(estj, jp, j, yes).

% =========================
% ESFJ
% =========================
matches(esfj, ei, e, yes).
matches(esfj, sn, s, yes).
matches(esfj, tf, f, yes).
matches(esfj, jp, j, yes).

% =========================
% ISTP
% =========================
matches(istp, ei, i, yes).
matches(istp, sn, s, yes).
matches(istp, tf, t, yes).
matches(istp, jp, p, yes).

% =========================
% ISFP
% =========================
matches(isfp, ei, i, yes).
matches(isfp, sn, s, yes).
matches(isfp, tf, f, yes).
matches(isfp, jp, p, yes).

% =========================
% ESTP
% =========================
matches(estp, ei, e, yes).
matches(estp, sn, s, yes).
matches(estp, tf, t, yes).
matches(estp, jp, p, yes).

% =========================
% ESFP
% =========================
matches(esfp, ei, e, yes).
matches(esfp, sn, s, yes).
matches(esfp, tf, f, yes).
matches(esfp, jp, p, yes).

% =========================
% DEFAULT RULE (IMPORTANT)
% =========================

matches(_, _, _, no).