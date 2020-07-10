// Source: https://github.com/daliansky/OC-little
DefinitionBlock("", "SSDT", 2, "DRTNIA", "GPI0", 0)
{
    External(SMD0, FieldUnitObj)
    External(SMGP, FieldUnitObj)
    External(GPMN, FieldUnitObj)

    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            GPMN = One
            SMD0 = Zero
            SMGP = One
        }
        Else
        {

        }
    }
}
