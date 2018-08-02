From: Hendrik Brueckner <brueckner@linux.ibm.com>
Date: Thu, 02 Aug 2018 09:56:29 +0000
Subject: Re: [PATCH 2/5] zipl: Rename FSDUMP_PART_* macros
Message-Id: <20180802095629.GB5361@linux.ibm.com>
In-Reply-To: <008e135a-bad5-98a6-1a90-f3edfc21c72d@redhat.com>
References: <008e135a-bad5-98a6-1a90-f3edfc21c72d@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 25, 2018 at 01:36:12PM +0200, Philipp Rudo wrote:
> The macro names are a mixture of the original file system dumper (FSDUMP)
> and its extension to cut the file system and write directly to a partition
> (PART). The original dumper no longer exists and today the feature is
> called zfcpdump. Prevent confusion by renaming the macros to fit todays
> usage.
> 
> Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
> ---
>  zipl/include/zipl.h |  4 ++--
>  zipl/src/job.c      | 10 +++++-----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/zipl/include/zipl.h b/zipl/include/zipl.h
> index 7670a0f9..fb68ae88 100644
> --- a/zipl/include/zipl.h
> +++ b/zipl/include/zipl.h
> @@ -48,9 +48,9 @@
>  #define MENU_DEFAULT_PROMPT		0
>  #define MENU_DEFAULT_TIMEOUT		0
>  
> -#define FSDUMP_PART_IMAGE	STRINGIFY(ZFCPDUMP_DIR) "/" \
> +#define ZFCPDUMP_IMAGE		STRINGIFY(ZFCPDUMP_DIR) "/" \
>  					STRINGIFY(ZFCPDUMP_PART_IMAGE)
> -#define FSDUMP_PART_RAMDISK	STRINGIFY(ZFCPDUMP_DIR) "/" \
> +#define ZFCPDUMP_INITRD		STRINGIFY(ZFCPDUMP_DIR) "/" \
>  					STRINGIFY(ZFCPDUMP_PART_RD)
>  
>  #define MAX_DUMP_VOLUMES		32
> diff --git a/zipl/src/job.c b/zipl/src/job.c
> index e6d29818..22d2549b 100644
> --- a/zipl/src/job.c
> +++ b/zipl/src/job.c
> @@ -874,22 +874,22 @@ check_job_dump_images(struct job_dump_data* dump, char* name)
>  {
>  	int rc;
>  	/* Add data needed to convert fs dump job to IPL job */
> -	rc = misc_check_readable_file(FSDUMP_PART_IMAGE);
> +	rc = misc_check_readable_file(ZFCPDUMP_IMAGE);
>  	if (rc) {
>  		error_text("Need external file '%s' for partition dump",
> -			   FSDUMP_PART_IMAGE);
> +			   ZFCPDUMP_IMAGE);
>  		return rc;
>  	}
> -	dump->image = misc_strdup(FSDUMP_PART_IMAGE);
> +	dump->image = misc_strdup(ZFCPDUMP_IMAGE);
>  	if (dump->image == NULL)
>  		return -1;
>  	dump->image_addr = DEFAULT_IMAGE_ADDRESS;
>  
>  	/* Ramdisk is no longer required with new initramfs dump system */
> -	if (misc_check_readable_file(FSDUMP_PART_RAMDISK))
> +	if (misc_check_readable_file(ZFCPDUMP_INITRD))
>  		dump->ramdisk = NULL;
>  	else {
> -		dump->ramdisk = misc_strdup(FSDUMP_PART_RAMDISK);
> +		dump->ramdisk = misc_strdup(ZFCPDUMP_INITRD);
>  		if (dump->ramdisk == NULL)
>  			return -1;
>  		dump->ramdisk_addr = UNSPECIFIED_ADDRESS;

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
