Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9E3BED16
	for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173299; cv=none; b=YXaO8vf1Nr7v5GT6HodtGHfr7XLQLrhnnwGm8gbqS+i6ZQpiu32A9t3Hpj5Ecdg8gR6N+Ar4awXBtK8Rqyo+tzuIFdk/pYctq+ItuNG0ZLXI49NGfEO6vWWlqoy6KpDLISc90hgmlZkFTf1GRBzOu8ZQAz2qjNScDKQhCIQt0Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173299; c=relaxed/simple;
	bh=g+zLGbhMsxlq3gXNeYqrEL9pXE9QWiEaXduyVPFtohc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FILYc7EvwNITqJrVolK/QwrABqGwSz5M/Z2kgYwUea8tkZy9LNRNSDByT8m1AxFxzwoqiy/oc6vC/EORZQ/nrx15V26ohD18Z8p4Ai3dx0tId0AwHTntNB5gLHkkhCbidFvhomtJ5BlkjqCiddUOCqPNwjbN5qj4hhi3xbHq+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=fpBmzwUT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="fpBmzwUT"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-460166910e6so4128122f8f.2
        for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781173293; x=1781778093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ks9XZxCyDCZpPl0hZOLfLDZkVcVXMB4BMtGl2dtDnVQ=;
        b=fpBmzwUTySw/uiKDGqQbqoKpktladXcRVPQD8sdhH5800qPk8c1zMxZcvIndfbGt2I
         IQDVTckZtX67LYZbu72rZxgvtoqDpUKSJRUtYpG9geKANvGiJbGhWBWsD2otq5CuToR4
         AVV9+3E0InG/YX7WK5cjputrEPHICe60ZFboRlVZ0dksZg632/CgoJWaCRZXbLxHn5n6
         Y1i2kV/VS1m5NK/rrLXNSpzoa8JDCXlFN8EfrqkLcdIdOguUlVQIkTPI6cELj2jhs1di
         GQ/Epo5IAI3BmeKBm/4WttY+FbhkImK+vIhHXj4Fzu2DqyYmsg9mRd2kuTpHBzbQ8jNT
         FS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781173293; x=1781778093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ks9XZxCyDCZpPl0hZOLfLDZkVcVXMB4BMtGl2dtDnVQ=;
        b=KgDEpuIwmwxJ6FSIlCmIkM4XACKqbIEnaGfucfcI+X98ibQWlTiaxNF1EXu3DOGaje
         LNUnjmLBAM+OgqU+P2QwNdm2omdnyvs1f4viEJ5lf+zDyyfMGlEnzEGI1TPiNC4pUZ1y
         oMcG1hT2jLa2lTg6lh8+tpn2T59fL8s7YAkvij2a1RYUkR8gzacFsZxiyIMwIbjR/90p
         Tx1dLMSQpT7xwCBhtqUq8SKdoQT+3D5p2+lF8dLEY3Wdl1ZmMQcjU4XDeaQ56hgliU2C
         Lkr/yDtIcQ90HyZqNVWkn5AuWn4XKJpcZL5hhT56NEMEqqqBZDGT38p43GYuKxf6VQjE
         bI4w==
X-Forwarded-Encrypted: i=1; AFNElJ9fQe1B6rEMuv57zWuYv3jNn0FLJEt4TY71BXlyOUe/suuhcJKbJNfB7FclQY7tlKllcT4QYAfDiQCg@vger.kernel.org
X-Gm-Message-State: AOJu0YydZk27r4odf3c/1ld9TrFCllawfvVfv1kJOZ8c7MaCqgKUTWoU
	6LY1LVFpb0/vejJLTU3C/z2BVAKuTAP2s4PpyGrigWzFpkNx893IikaVEapasEAWRXo=
X-Gm-Gg: Acq92OEwj3hM7FkMRbiR0pjkVYTk3OEbdpxmAHuuZbcOa3Fvo2iIuTiVh5yO5JAz/D8
	Y7Fn6FNAbP7osaeb1ATxlhaNY32vVNWxM4OKFgQ8Uz/x82Q33xTT4Mh0O3aUOXHvtx5TXc5fSC2
	mIFV4zq09ZW275ggJxzrI7ieIkbPtpyrDdBZ8jV1ZNvEdCzDL0+eyXrOP03Tng7KFX3GSKOXmzg
	SGuevQaioYyAg1LSF3qFv9dgpFml8AztUoWN8yrIBsxtLsnbyZJyBNNVAquTfLYXbC9Dx2hR8jx
	tty4ZCDmNoFvo78OPKvNUQQr72/IlfU7wn8YDa80JdyCL9ovs5bWNtXBSY1dnJHKqqpk/MNvibP
	W4cfSTFwG26It21HdLYPfIbWXvl5edL4D8WN7STEYsXglzeYUYOCS6liq865ffZ8PJxPLNiq5Y4
	sK8AxUCU7ddTdZNRu5FFtXxw4o74Bba+iQ2UoUPg==
X-Received: by 2002:a05:6000:1449:b0:43c:ef4f:79e4 with SMTP id ffacd0b85a97d-460677c149emr3057787f8f.37.1781173293060;
        Thu, 11 Jun 2026 03:21:33 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm68603644f8f.32.2026.06.11.03.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:21:32 -0700 (PDT)
Date: Thu, 11 Jun 2026 12:21:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: christian.koenig@amd.com, jgg@ziepe.ca, hch@infradead.org, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, djbw@kernel.org, 
	thomas.lendacky@amd.com, x86@kernel.org, arnd@linaro.org, benjamin.gaignard@collabora.com, 
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com, mripard@kernel.org, 
	afd@ti.com, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] dma-buf: move system_cc_shared heap under separate
 Kconfig
Message-ID: <aiqLJUrJ1dnKhsJn@FV6GYCPJ69>
References: <20260610142329.3836808-1-sumit.semwal@linaro.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610142329.3836808-1-sumit.semwal@linaro.org>

Wed, Jun 10, 2026 at 04:23:29PM +0200, sumit.semwal@linaro.org wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>While system heap and system_cc_shared heap share a lot of code
>and hence the same source file, their users have different needs.
>
>system heap users need it to be a loadable module, while
>system_cc_shared heap users don't.
>
>Building as a loadable module breaks system_cc_shared heap on
>powerpc and s390 due to un-exported set_memory_encrypted /
>set_memory_decrypted functions.
>
>Fix these by reorganising code to put the system_cc_shared heap
>under a new Kconfig symbol, which allows either building both
>into the kernel, or leave encryption up to the consumers of the
>system heap.
>
>Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
>---
> drivers/dma-buf/heaps/Kconfig       |  8 ++++++++
> drivers/dma-buf/heaps/system_heap.c | 16 ++++++++++------
> 2 files changed, 18 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
>index e273fb18feca..a39decdcf067 100644
>--- a/drivers/dma-buf/heaps/Kconfig
>+++ b/drivers/dma-buf/heaps/Kconfig
>@@ -5,6 +5,14 @@ config DMABUF_HEAPS_SYSTEM
> 	  Choose this option to enable the system dmabuf heap. The system heap
> 	  is backed by pages from the buddy allocator. If in doubt, say Y.
> 
>+config DMABUF_HEAPS_CC_SYSTEM

Nit: "DMABUF_HEAPS_SYSTEM_CC_SHARED" to be consistent with the heap
name?

With or without it:
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

