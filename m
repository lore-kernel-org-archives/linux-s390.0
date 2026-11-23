Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441431;
	b=2ZWaZ1U+2WjEXixrksmzEiupxLWsPIQVFuX44eZCzv1G9NTo4128EQ0cjx9yzP7onsdG
	 mAqBOKBWmLqbwEWyIvFOu1A/0SAC9M+4bUHEz63Owjs1+4D6ypwmzQiJD4Y5uUW47aPEa
	 nafpyZV62u1W96FXtNBAu6Tbp2DIWGibP98m0woUxOfRO6sxNiVfYKO0xzS/b9JACLqsw
	 fxXHzYkkOZb9Z3htpa7wXdeq4V2zsMXZ1kU4f+0aJCSxOEZ2L8x8dMiAaePssKqLf8cHn
	 JWeKkq97kiO7LBgydS318PwKEdIXGWdZbA37H1nGrSkhHvx2ne6prOZ1ySuAA0njaEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441431;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=K6tlmRUimWZhcGdPxMJ4az4j/dwJ78x8KYKcWyDjcE8=;
	b=FqZgn4aQj/6mrdY8NAZBviY2XsMDRiJQ3z1yV4wKb5WeGuUU9F0fPgcfWZBZpBoOnht8
	 STKJPlwMpiwKL5U3XG59b0VvCXvxCMaTxeJ53gEYRahLRaK449Ch1k+YZRZV/reyLGLR5
	 rGAYVYSUF+OCZdJszzzEGKjSTWNkAG02P6KMLsSJgCsgfJykFceBxKR5I1+1aTviHvFAZ
	 JhVaL5lR5m8dgZ4oVR9tbIl7ysMZyu6MxYdcsEiFyL7rkTZGrJt182libcCMldUxhIvgL
	 LVRaN8E6FbK680jBoiNJmi/G1Mm9QTn46NgEq3SmYbxv4SbMbggOQHm5tJjbN3EbN8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZWYZyDi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 45FBB606A31A;
	Mon, 23 Nov 2026 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZWYZyDi
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 52FEF1F000C4;
	Mon, 23 Nov 2026 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795441430;
	bh=K6tlmRUimWZhcGdPxMJ4az4j/dwJ78x8KYKcWyDjcE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PZWYZyDi8SVFutujfs+sQSLaL+UvPGfVmhvlqmR+yi2hf25D3OoRHH5Ghac+rytLE
	 3PkYSUtxLFrrJz5a4wCD2gxA5eQU3AmWYJeZilDKyF+3GOa0AlTHRdmW/XcGhD6ZnS
	 ED59jFBb3QD4YyxCRnPnNHrV1P8OWc4o0/DjifxK9WFMCi1XALO6/TYab041ferr+A
	 jeCM8+JJHu3SY/dK8rjh4Ps2lNLvJbyDuhQy4mi02Z+i0bei1WNn+a3Y3WtPyEzvkA
	 HU3VBlm0Zl2StuK2D6eX0U/KU1E/ACUvTQAS5Wqx6xmCzDEHm+UxFxJoK3mH3fx9Gs
	 K5GoNF5eioGBQ==
Date: Mon, 23 Nov 2026 15:43:47 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/cert_store: Only allow the kernel to create
 cert_store_key keys
Message-ID: <awRDE-HZNcxGqmiv@kernel.org>
References: <20261123102324.483917-1-hca@linux.ibm.com>
 <20261123102324.483917-3-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123102324.483917-3-hca@linux.ibm.com>

On Mon, Nov 23, 2026 at 11:23:24AM +0100, Heiko Carstens wrote:
> From: Anastasia Eskova <anastasia.eskova@ibm.com>
> 
> Keys of type cert_store_key can be created by any user with add_key() in
> any keyring, as the key type has no vet_description() callback. The type
> is registered whenever CONFIG_CERT_STORE is enabled, even if the machine
> has no DIAG 320 support.
> 
> cert_store_key_describe() expects a description in the format created by
> get_key_description(), i.e. a 64 byte key name followed by the VCE index
> and the certificate store token. If a key with a shorter description is
> created, seq_puts() may read beyond the end of the description
> allocation. Reading /proc/keys may then disclose adjacent kernel heap
> memory to the user space. Also, a consumer which trusts keys by type can
> be fooled by keys that were not created from the certificate store.
> 
> Add a vet_description() callback which only accepts the task currently
> executing refresh_store(), which creates all valid keys of this type.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Anastasia Eskova <anastasia.eskova@ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/cert_store.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index 6f5c63cd907f..6e518ff38322 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
> @@ -46,6 +46,9 @@
>  static debug_info_t *cert_store_dbf;
>  static debug_info_t *cert_store_hexdump;
>  
> +/* Task currently running refresh_store(). Written under cs_refresh_lock. */
> +static struct task_struct *cs_refresh_task;
> +
>  #define pr_dbf_msg(fmt, ...) \
>  	debug_sprintf_event(cert_store_dbf, 3, fmt "\n", ## __VA_ARGS__)
>  
> @@ -148,12 +151,24 @@ static void cert_store_key_describe(const struct key *key, struct seq_file *m)
>  		seq_printf(m, ": %u", key->datalen);
>  }
>  
> +/*
> + * Only the kernel may create keys of this type. Accept the task which runs
> + * refresh_store(), as it cannot execute userspace during the refresh.
> + */
> +static int cert_store_key_vet_description(const char *description)
> +{
> +	if (READ_ONCE(cs_refresh_task) != current)
> +		return -EPERM;
> +	return 0;
> +}
> +
>  /*
>   * Certificate store key type takes over properties of
>   * user key but cannot be updated.
>   */
>  static struct key_type key_type_cert_store_key = {
>  	.name		= CERT_STORE_KEY_TYPE_NAME,
> +	.vet_description = cert_store_key_vet_description,
>  	.preparse	= user_preparse,
>  	.free_preparse	= user_free_preparse,
>  	.instantiate	= generic_key_instantiate,
> @@ -768,6 +783,7 @@ static ssize_t refresh_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	if (rc)
>  		return rc;
>  
> +	WRITE_ONCE(cs_refresh_task, current);
>  	for (retries = 0; retries < DIAG_MAX_RETRIES; retries++) {
>  		/* Request certificates from certificate store. */
>  		rc = fill_cs_keyring();
> @@ -776,6 +792,7 @@ static ssize_t refresh_store(struct kobject *kobj, struct kobj_attribute *attr,
>  		if (rc != -EAGAIN)
>  			break;
>  	}
> +	WRITE_ONCE(cs_refresh_task, NULL);
>  	cs_status_val = rc;
>  	mutex_unlock(&cs_refresh_lock);
>  
> -- 
> 2.53.0
> 

I can give this despite a bit out of context for me because I'm already
somewhat familiar with the implementation overall:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
