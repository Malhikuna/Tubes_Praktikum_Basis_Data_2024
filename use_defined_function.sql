IF OBJECT_ID('dbo.HitungPersentase') IS NOT NULL DROP FUNCTION dbo.HitungPersentase;
CREATE FUNCTION dbo.HitungPersentase (
    @JumlahKehadiran INT,
    @TotalRapat INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Persentase DECIMAL(10, 2);

    IF @TotalRapat = 0
        SET @Persentase = 0;
    ELSE
        SET @Persentase = CAST((CAST(@JumlahKehadiran AS DECIMAL(10, 2)) / @TotalRapat * 100) AS INT)

    RETURN @Persentase;
END;
GO