Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 4 Jun 2014 23:59:12 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: scsi: zfcp_aux.c:  Cleaning up missing
 null-terminate after strncpy call
Message-ID: <20140604215912.GA3702@osiris>
References: <1401917471-2869-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1401917471-2869-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Steffen Maier <maier@linux.vnet.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jun 04, 2014 at 11:31:11PM +0200, Rickard Strandqvist wrote:
> Added a guaranteed null-terminate after call to strncpy.
> 
> This was partly found using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  drivers/s390/scsi/zfcp_aux.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
> index 8004b07..138b84a 100644
> --- a/drivers/s390/scsi/zfcp_aux.c
> +++ b/drivers/s390/scsi/zfcp_aux.c
> @@ -102,6 +102,7 @@ static void __init zfcp_init_device_setup(char *devstr)
>  	if (!token || strlen(token) >= ZFCP_BUS_ID_SIZE)
>  		goto err_out;
>  	strncpy(busid, token, ZFCP_BUS_ID_SIZE);
> +	busid[sizeof(busid) - 1] = '\0';

Erm.. with
	char busid[ZFCP_BUS_ID_SIZE];
just a couple of lines above this seems to be rather pointless.
However _if_ we change the code then replacing strncpy() with strlcpy()
would be the way to go.
