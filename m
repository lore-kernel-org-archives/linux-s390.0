From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Tue, 23 May 2017 06:17:28 +0000
Subject: Re: [RFC PATCH] s390: Remove 'message security assist' from the list of vital facilities
Message-Id: <20170523061728.GA8117@osiris>
In-Reply-To: <1495466453-27609-1-git-send-email-thuth@redhat.com>
References: <1495466453-27609-1-git-send-email-thuth@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, May 22, 2017 at 05:20:53PM +0200, Thomas Huth wrote:
> The code in arch/s390/crypto checks for the availability of the
> 'message security assist' facility on its own, either by using
> module_cpu_feature_match(MSA, ...) or by checking the facility
> bit during cpacf_query(). Thus setting the MSA facility bit in
> gen_facilities.c as hard requirement is not necessary. We can
> remove it here, so that the kernel can also run on systems that
> do not provide the MSA facility yet (like the emulated environment
> of QEMU, for example).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: Not sure whether I've missed something here and the facility
>  is urgently required somewhere else, where the code does not have
>  these additional checks like in arch/s390/crypto - that's why I've
>  marked the patch with "RFC" ... so if anybody has more insights,
>  please let me know!

That bit was part of the initial conversion from machine type to
facilities: 8c4caa4fbfc1 ("[S390] use facility list for cpu type safety
check"). However even that old code did have a facility check for bit 17
within the crypto code.

>  arch/s390/tools/gen_facilities.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index be63fbd..cfe3f76 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -35,7 +35,6 @@ struct facility_def {
>  #endif
>  #ifdef CONFIG_HAVE_MARCH_Z9_109_FEATURES
>  			7,  /* stfle */
> -			17, /* message security assist */

We could also remove the stfle bit, since the kernel also always checks if
it is available before executing the instructions.

Looking at the facility list: stfle is the only odd one left. So I will
remove that one as well.

Applied your patch. Thanks!
