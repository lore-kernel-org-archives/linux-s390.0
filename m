Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609DC284686
	for <linux-s390@vger.kernel.org>; Tue, 10 Feb 2026 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770690202; cv=none; b=KtZMGs8tNVH7d6e6Qas1yzs0l1AwbQqSGzL0D6AgCrwkzCG5ss829vK08lDpeoqQu7V0SXwwc6qR/hxCqyHSTByJwaBHeMOdZUqBLCfsFad4arGEYvZ4uRIeQ2KoAPtUQ27VKNuB4zJHtUoTECP4WxFuZEoEDfTC8Ad0VDFnNXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770690202; c=relaxed/simple;
	bh=37iyJlcCxpSR9Agg2+LOwq+Ns4zzbNv40E48U8LliVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftTrpdERu0Kob3YWkYmpCFAeFv37MnO72stxLF0lq3k7o2Rf3OpnydNKWiCqo557w7CDAXjuvO4nIJKaTtxW7qKF23dj/OHpl/TfJ1Hkh5RPzXPVXDGWSkin3cRdX5E/yEbCwFd4LeExERPExy7TgN+XVPCyshulq+Zxk1IHWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmiCUE4R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmiCUE4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770690199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nrld4QUPFG908ozuxCRcRQrQXDKpD/pbHu8Ax6np3ME=;
	b=YmiCUE4RVADOx21ACrypuJy0hEuyspAaP2d843NMMbCl8BOb3zO5rxncGt1uZz05EOg1kE
	FUTUbU/13qrsNbNDwzLFLoyL+tegQCFexB/Xr0nWkUHNCAeXHE3Lg8fKjiivIyuU5VobYV
	Ld2ruqWVWF/8HWaKkeaCRPwk55XHJQE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-NzdXD7atM0y6A-MYsrfvaA-1; Mon,
 09 Feb 2026 21:23:17 -0500
X-MC-Unique: NzdXD7atM0y6A-MYsrfvaA-1
X-Mimecast-MFC-AGG-ID: NzdXD7atM0y6A-MYsrfvaA_1770690196
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 353121955DD3;
	Tue, 10 Feb 2026 02:23:16 +0000 (UTC)
Received: from localhost (unknown [10.72.112.171])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AC7C1800464;
	Tue, 10 Feb 2026 02:23:13 +0000 (UTC)
Date: Tue, 10 Feb 2026 10:23:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Alexander Egorenkov <egorenar@linux.ibm.com>,
	linux-s390@vger.kernel.org
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org
Subject: Re: [RESEND PATCH v1 1/1] s390/kexec: Make KEXEC_SIG available when
 CONFIG_MODULES=n
Message-ID: <aYqWhWQO265YRnPP@fedora>
References: <20260209133308.118364-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209133308.118364-1-egorenar@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/09/26 at 02:33pm, Alexander Egorenkov wrote:
> The commit c8424e776b09 ("MODSIGN: Export module signature definitions")
> replaced the dependency of KEXEC_SIG on SYSTEM_DATA_VERIFICATION with
> the dependency on MODULE_SIG_FORMAT. This change disables KEXEC_SIG
> in s390 kernels built with MODULES=n if nothing else selects
> MODULE_SIG_FORMAT.
> 
> Furthermore, the signature verification in s390 kexec does not require
> MODULE_SIG_FORMAT because it requires only the struct module_signature and,
> therefore, does not depend on code in kernel/module_signature.c.
> 
> But making ARCH_SUPPORTS_KEXEC_SIG depend on SYSTEM_DATA_VERIFICATION
> is also incorrect because it makes KEXEC_SIG available on s390 only
> if some other arbitrary option (for instance a file system or device driver)
> selects it directly or indirectly.
> 
> To properly make KEXEC_SIG available for s390 kernels built with MODULES=y
> as well as MODULES=n _and_ also not depend on arbitrary options selecting
> SYSTEM_DATA_VERIFICATION, we set ARCH_SUPPORTS_KEXEC_SIG=y for s390 and
> select SYSTEM_DATA_VERIFICATION when KEXEC_SIG=y.

Thanks for fixing the issue.

Seems the background and change is a little twisting, and selecting
SYSTEM_DATA_VERIFICATION will cause a bunch of verification feature
selected. While the change is only s390 related, request s390 expert to
have look at this change. If no concern from s390 developer, I am also
fine to it.

Thanks
Baoquan
> 
> Fixes: c8424e776b09 ("MODSIGN: Export module signature definitions")
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  arch/s390/Kconfig    | 2 +-
>  kernel/Kconfig.kexec | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index c2c7bf974397..385c1052cf45 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -313,7 +313,7 @@ config ARCH_SUPPORTS_KEXEC_FILE
>  	def_bool y
>  
>  config ARCH_SUPPORTS_KEXEC_SIG
> -	def_bool MODULE_SIG_FORMAT
> +	def_bool y
>  
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
>  	def_bool y
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 15632358bcf7..df97227cfca9 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -50,6 +50,7 @@ config KEXEC_SIG
>  	bool "Verify kernel signature during kexec_file_load() syscall"
>  	depends on ARCH_SUPPORTS_KEXEC_SIG
>  	depends on KEXEC_FILE
> +	select SYSTEM_DATA_VERIFICATION if S390
>  	help
>  	  This option makes the kexec_file_load() syscall check for a valid
>  	  signature of the kernel image. The image can still be loaded without
> -- 
> 2.51.0
> 

