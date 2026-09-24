Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2037E2E2
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230495; cv=none; b=YF6IHyvPAx0fZ51/eiedBmWvKY2DwQhmoxUaHckzZCRGdlZcgjBHsU2AvMdaMF+YF1+5XbKXb9En7xcjUDrjxQPVDxIYAyNxCGlgrmnCDfPS/3jR0EfR1FsoO0AcyAOLeRfw+0SMigbrZ41w1UgYpOnLVwc1uvdsYAD4LJbhEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230495; c=relaxed/simple;
	bh=7RCFdrvT0CXmTNLIraQusBc/SfLDQRI6xF7HUEJYxgI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b2YX6WghelKi3Qo8beh7HxxV9uEc8QcocbLaQSIIsVZopTnWxeUKLE+8hyBKTOT3sABVG9wNtxOpK5RwenzYy3vsPmnhNypXq6FIdjElNc90dCDmu7+Lgofx7QSQLBxWSRhDmVoHi8FJc7aJTnS4Xzv5Jmzy2imXO9upNL6UIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqN/5Yly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqN/5Yly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FE91F000FF;
	Thu, 24 Sep 2026 06:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230494;
	bh=QK0QpfiT0/EjLthpGveTMU7J099OJgm+Gf5qHkNKBb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DqN/5YlySM94zBWQVGTC+LXMmse+4/gJqAan+K+lx1bh3DhkeUQLEnB2ktdzpePge
	 04BLxUD2D4dPiR/ZIsvpKdTToKC1iRml8d7WjyNfwXQy0+D/UIGVCmi6qhGxJgy6WR
	 ty3TXn/MPqBdAXkUNUsa9fYeWiW70960mydGw4y2gNIgNYsPw/YdMjeQh3TmK7ZZJV
	 gb3GUDu9fAenqoJDca8XXHHs+U3BlqevSZqz0L2/2hkwSc+KOv9M3hkr2yzz4Hfp5G
	 1R5eLXLVYuKYVhF7e7sct1l3d279T/WoMW9NvtN1IEo5KztMo1IASUpfzF/yjskI1x
	 VPGtBRiOdInQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/8] dma: swiotlb: Rename swiotlb_size_or_default()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260924060756.1325156-2-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-2-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:14:53 +0000
Message-Id: <20260924061453.A7FE91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] docs: missed function rename to swiotlb_default_pool_size()
--

commit 88c990f98bc8ebb1b961e1f014a4e9bab02d6131
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

dma: swiotlb: Rename swiotlb_size_or_default()

This commit renames swiotlb_size_or_default() to swiotlb_default_pool_size()
to clarify that it returns the current size of the default pool. This inclu=
des
sizes resulting from command-line modifications or heuristics, not just the
compiled-in default.

> diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/=
crash_reserve.h
> index 7835b2cdff04a..047f638a766d7 100644
> --- a/arch/x86/include/asm/crash_reserve.h
> +++ b/arch/x86/include/asm/crash_reserve.h
[ ... ]
> @@ -33,7 +33,7 @@ extern unsigned long swiotlb_size_or_default(void);
>  static inline unsigned long crash_low_size_default(void)
>  {
>  #ifdef CONFIG_X86_64
> -	return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
> +	return max(swiotlb_default_pool_size() + (8UL << 20), 256UL << 20);

[Severity: Low]
Since the function swiotlb_size_or_default() is renamed to
swiotlb_default_pool_size() here in crash_low_size_default(), does the
corresponding documentation in Documentation/admin-guide/kernel-parameters.=
txt
also need to be updated?

The documentation string currently still uses the old function name to expl=
ain
the crashkernel reservation formula on x86:

Documentation/admin-guide/kernel-parameters.txt:
        --> x86: max(swiotlb_size_or_default() + 8MiB, 256MiB)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924060756.1325=
156-1-aneesh.kumar@kernel.org?part=3D1
