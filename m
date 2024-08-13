Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8118919A2AE;
	Tue, 13 Aug 2024 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546280; cv=none; b=qQK3QNGOyr3G7SZgq9bLrtH1jj5d9xLyv1g2lDIBThXIllFzLE62LaeY81CuAMPNLo2YXgSWep+3RI/92ijbGywFg4wWhPx3XikUQC11Q3JblPlPGt3y+zu0E6Pw3NK1pQ9NVlwv+05ZADIUIGqWUV8AwViEbCuEtWzaYkTAfrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546280; c=relaxed/simple;
	bh=fWki4buPtvxnd6GRqmAcFmi2Hw8+JFniKOPIVO3kJ90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpabrUP3NwyPC4ePghDPrPFnDZjzTDL3ORCuzX+oPUyTlfkeIg9PbhSbV4xFaiEHhN4ADbkXaKFymeg6gSjW8pJil5FdCpJ/BQ/+ttdOt/jHP1XxASUoiAxtuU7VVQQlZTMOkC1+kRWKyQFa+ikOP1vUqcDjBBx223r6BTVrmJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GC92hL57; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GC92hL57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73FCC4AF09;
	Tue, 13 Aug 2024 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723546280;
	bh=fWki4buPtvxnd6GRqmAcFmi2Hw8+JFniKOPIVO3kJ90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GC92hL57H9HywSyy9qqpHut+y9U4rJw9a729t969FaH7mdcfzcWbuoet8wEpQrmDl
	 8bcY2J6hySOX2s0Bj6irGwBdVs5gCZiVlMtDO/8d90IVROP04VN8X3nedGZ84aTxbj
	 rUvycdbH6jfzBZHNN3wRI1fQxqwpAW/6RI5fy1X8=
Date: Tue, 13 Aug 2024 12:51:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Alexandra Winter <wintera@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] kobject: Export kobject_set_name_vargs() symbol
Message-ID: <2024081326-shifter-output-cb8f@gregkh>
References: <cover.thread-d8267b.your-ad-here.call-01723545029-ext-2515@work.hours>
 <patch-1.thread-d8267b.git-25e808605154.your-ad-here.call-01723545029-ext-2515@work.hours>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch-1.thread-d8267b.git-25e808605154.your-ad-here.call-01723545029-ext-2515@work.hours>

On Tue, Aug 13, 2024 at 12:42:34PM +0200, Vasily Gorbik wrote:
> The net/iucv module requires the kobject_set_name_vargs() function to
> set kobject names dynamically based on variable arguments. Export the
> kobject_set_name_vargs() symbol, allowing the net/iucv module and other
> potential modules to use this utility function.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408091131.ATGn6YSh-lkp@intel.com/
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  lib/kobject.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 72fa20f405f1..96caa8bfdc40 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -295,6 +295,7 @@ int kobject_set_name_vargs(struct kobject *kobj, const char *fmt,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(kobject_set_name_vargs);

EXPORT_SYMBOL_GPL() please.

thanks,

greg k-h
