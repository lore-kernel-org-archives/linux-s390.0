Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190208024110.8021-1-allen.lkml@gmail.com> <20190208083808.GB2803@osiris>
In-Reply-To: <20190208083808.GB2803@osiris>
From: Allen <allen.lkml@gmail.com>
Date: Fri, 8 Feb 2019 16:35:42 +0530
Message-ID: <CAOMdWSK=JOQkS+nce+1YXZQFoYE5OgJTb2QuoWN_iP8tHvE3Pw@mail.gmail.com>
Subject: Re: [PATCH] Use ARRAY_SIZE instead of dividing sizeof array with
 sizeof an element.
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> >
> > diff --git a/arch/s390/tools/gen_opcode_table.c b/arch/s390/tools/gen_opcode_table.c
> > index a1bc02b29c81..468b70c85f62 100644
> > --- a/arch/s390/tools/gen_opcode_table.c
> > +++ b/arch/s390/tools/gen_opcode_table.c
> > @@ -138,7 +138,7 @@ static struct insn_type *insn_format_to_type(char *format)
> >       strcpy(tmp, format);
> >       base_format = tmp;
> >       base_format = strsep(&base_format, "_");
> > -     for (i = 0; i < sizeof(insn_type_table) / sizeof(insn_type_table[0]); i++) {
> > +     for (i = 0; i < ARRAY_SIZE(insn_type_table); i++) {
>
> This does not compile.
>
   Surprising. I try it out again.

Thanks.

-- 
       - Allen
