Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 8 Feb 2019 09:38:08 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] Use ARRAY_SIZE instead of dividing sizeof array with
 sizeof an element.
References: <20190208024110.8021-1-allen.lkml@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190208024110.8021-1-allen.lkml@gmail.com>
Message-Id: <20190208083808.GB2803@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 08, 2019 at 08:11:10AM +0530, Allen wrote:
> From: Allen Pais <allen.lkml@gmail.com>
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  arch/s390/tools/gen_opcode_table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/tools/gen_opcode_table.c b/arch/s390/tools/gen_opcode_table.c
> index a1bc02b29c81..468b70c85f62 100644
> --- a/arch/s390/tools/gen_opcode_table.c
> +++ b/arch/s390/tools/gen_opcode_table.c
> @@ -138,7 +138,7 @@ static struct insn_type *insn_format_to_type(char *format)
>  	strcpy(tmp, format);
>  	base_format = tmp;
>  	base_format = strsep(&base_format, "_");
> -	for (i = 0; i < sizeof(insn_type_table) / sizeof(insn_type_table[0]); i++) {
> +	for (i = 0; i < ARRAY_SIZE(insn_type_table); i++) {

This does not compile.
