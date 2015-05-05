create or replace type body petet_sum_interval is

  -------------------------------------------------------------------------------------------------
  constructor function petet_sum_interval return self as result
    parallel_enable is
  begin
    return;
  end petet_sum_interval;

  -------------------------------------------------------------------------------------------------
  static function odciaggregateinitialize(ctx in out petet_sum_interval) return number is
  begin
    ctx := petet_sum_interval();
    return odciconst.success;
  end odciaggregateinitialize;

  -------------------------------------------------------------------------------------------------
  member function odciaggregateiterate
  (
    self  in out petet_sum_interval,
    value in interval day to second
  ) return number is
  begin
    if SELF.duration is null
    then
      SELF.duration := value;
    else
      SELF.duration := SELF.duration + value;
    end if;
    return odciconst.success;
  end odciaggregateiterate;

  -------------------------------------------------------------------------------------------------
  member function odciaggregateterminate
  (
    self        in petet_sum_interval,
    returnvalue out interval day to second,
    flags       in number
  ) return number is
  begin
    returnvalue := SELF.duration;
    return odciconst.success;
  end odciaggregateterminate;

  -------------------------------------------------------------------------------------------------
  member function odciaggregatedelete
  (
    self  in out petet_sum_interval,
    value in interval day to second
  ) return number is
  begin
    SELF.duration := SELF.duration - value;
    return odciconst.success;
  end odciaggregatedelete;

  -------------------------------------------------------------------------------------------------
  member function odciaggregatemerge
  (
    self in out petet_sum_interval,
    ctx  in petet_sum_interval
  ) return number is
  begin
    if ctx.duration is null
    then
      null;
    else
      SELF.duration := SELF.duration + ctx.duration;
    end if;
    return odciconst.success;
  end odciaggregatemerge;

end;
/
