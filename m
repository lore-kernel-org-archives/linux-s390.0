Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792540138;
	b=PcN1PMDTUpWAFJyhJg9S+YF4bea7zjjsZeDeI8KtGmLFgcA0IMLawnLY8sjNCX6wW7mo
	 JOWdxONKn4rYH3QrxROfpXCcx4COrS5Ny2r2TAQ0xkZ97iclzXUNX6rOnKe6tNFDbz8vK
	 W40z06xJxi7BlyxDgxvzSbD4U0zZ6ynrAlAemdpVLvPEvQyO7Z4kIZZe4w1wZ1xbAY7e1
	 bB31Kcoda0xwS6eaojDsGPK/grWhL55+8B1LLvQtS3gWjZS85hICdtVmXSQyr5BYriFpY
	 o0NBg4FkgE6qTAnF6LOP12DazN9Fxz8nLP/TECDo8N16fuIZZhVFOzB/cCTyS0bGFUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792540138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=D1Nuj0c85bvBmNt2X1dkz5A5qEMgMEBKUot79cJMsS8=;
	b=fuqayaLN+Rb8W3AA5gx4YZr99nMgIkRf1VWKgOZsqJKB1X6G9SV2dU8bIy/XWODthJYr
	 D75imIJcl8hA4j8K7nR5dv8bIyhOV597LYOroBnolG3Zs+TZsQODpYiTYlpp5t6n4WAHQ
	 qDeb+qKYZCN4pvVuz1rHSle4yi127dhOS3ZuQu0cwV1bSHp9SY7IGQbJBNlPOfRwU/Yh6
	 bw0Jb0UoKJv2dtP2uq1HB7hkAblZsJh8xr06ER6AT3qRJkHFzR2BlMrG7xAtU902SxKxR
	 QJO7zAnc3UF6OymFwqfIU3qc8Y4jxTHSVIbD6LXUEy8eRbLRu/X/JB9fTgdCqY1sz1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=V2htlUnQ;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B051606A31A
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 23:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B051606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=V2htlUnQ
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso43288b3a.2
        for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792540137; x=1793144937; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D1Nuj0c85bvBmNt2X1dkz5A5qEMgMEBKUot79cJMsS8=;
        b=V2htlUnQI4mFScVT4WCEJvCyFfvGwJOvLHy2fV6tjXSuw7qnBh21d0hLgJHA3Mlug8
         itnzBgB3ZrO1GN6nXoftE23GS9PvFjqP94GTJ13t2/RR1IKmva9gigwohThc2d/Wwmd9
         Qa1qkmjK1rrM89uFvO+Vd3hKf1Ve6M81TRK8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792540137; x=1793144937;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D1Nuj0c85bvBmNt2X1dkz5A5qEMgMEBKUot79cJMsS8=;
        b=kBEJfJhKoyj6pLKPibHnwxN+KQgyA6l+RqIthRkmXaZJ4qjpFSdKms4GVW15Q3hMVc
         LwWMPEpiULJjyH0hwDSmlI/saIkCJkbbT16A03zvScorMg7Sl6mk/sAWaqtqUsAr85rG
         lIkKbnT0R44aO+cf0CI53qGamrLGS0qUavOYvust8brfr7e/tMfQWRA4GiNnd6t2w1FC
         hoCi/q5ekAWzqLWiytkm2AZWTnhTch3+m/ZFXg5ukSd1P4FDD+KNxmfagjodmrRKN6Bk
         Em337K5MWBip61j4e24wRig2EROhw91Wen+z4oG0jjeabIgJ1ldkl1fRliEs0CGFxsii
         hqCw==
X-Forwarded-Encrypted: i=1; AKwUvBy7q49owRQlzyI+ZeLGLlfbbAKJlaI4XNv+FoAhGhCPYGvSeMfTvyc8455fMbWbCNYHPV8jHnxn38Yp@vger.kernel.org
X-Gm-Message-State: AFq9FYKLBD1EJUewrfnog9kxJ981Xmjm4B6B4EIio8uGbS6s9OC8GMgt
	mo3OUSbXaj85moXSwR/OlAMYCff4j5TIMFvxWFyD/YaKTyas2FjXZZFV2lAjzN+kZoMDm9fbtiI
	TJbThx7LN
X-Gm-Gg: AYBFou3Xvx/bVLOpJfB5Do87NZO11oAULWsVEwBmD05fC1e9ahsUWlOjOe+3czlfVI8
	0qS61Cg2O/BkcpwtYhSKsZxswuneUVAWWrRMv+hDz1zGIs8GQ4DdwO7LUoxgkaSOd5heXPgognu
	JuEUSGpxeKmZ0XJCF+NWymG3eE/vjxwto/hZC2InC8ZqvEi4EIL6kXGuwRKrP9+N0Bjbu/at/mJ
	Ydoz7K98NIU7eq5qbxfrUJ79DGrn8IJzsWCVkg2Nai7P49Yqt8CbGwXAUTQjImsNsDibtB08vg5
	adiIXwfpFM5dHgr8zNS2XyfYdRAWO2Xt0FCXaNj7B3dq8VNfonRaCbk84kfi+ugayvAzo/zMgj9
	Z2fVssI2zoRHcpTVPtLzK/7CrRK+NllAs5DnrC1xfTMAFLzcXFTjWkDAqNVTL6Ey8Zl2cC3XI1g
	UKg1dfMeFzHbGZvTuxRWUZrL6X03RwKbt1AsqKPiWWLaMKiD5UCEbhv7AXXGk/h9egPXoO44k0Q
	D8lk3+6kWbFaGGmhmylK539CWTtw7bItHc=
X-Received: by 2002:a05:6a00:e11:b0:88b:9eca:951a with SMTP id d2e1a72fcca58-8a089c49a22mr335183b3a.1.1792540137411;
        Tue, 20 Oct 2026 16:48:57 -0700 (PDT)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com. [74.125.82.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895dc12asm151730b3a.40.2026.10.20.16.48.56
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 16:48:57 -0700 (PDT)
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-14fc585291cso16678c88.1
        for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 16:48:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzJKyAyyIiIOIls8sjwjZ1LH43Vq+bP7tx86MGOQZ+S3QmZ0ZYzSWkgYf1//74v0+6KtjNSOppGK4hJ@vger.kernel.org
X-Received: by 2002:a05:701b:270b:b0:187:a2b1:7b3a with SMTP id
 a92af1059eb24-190a6adcc50mr423407c88.41.1792540135068; Tue, 20 Oct 2026
 16:48:55 -0700 (PDT)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-kconfig-fix-mfentry-check-v1-0-428258bc0fc0@kernel.org>
In-Reply-To: <20261020-kconfig-fix-mfentry-check-v1-0-428258bc0fc0@kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 21 Oct 2026 08:48:40 +0900
X-Gmail-Original-Message-ID: <CANiDSCt=7SorMBAUXTohsSV_-6BZPrHbC9u80-P7=kYO4NiUJw@mail.gmail.com>
X-Gm-Features: AclHuK_NFTuQpEwblXCYU1ELdfOsTXBO_zAq82tRWKGwdXrwLnDaicFsmdlXQkQ
Message-ID: <CANiDSCt=7SorMBAUXTohsSV_-6BZPrHbC9u80-P7=kYO4NiUJw@mail.gmail.com>
Subject: Re: [PATCH 0/2] kbuild: Fallout from moving '-mfentry' check into
 Kconfig stage
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Julian Braha <julianbraha@gmail.com>, 
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Kees Cook <kees@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Nathan

Thanks for the series, it fixes the issue for media-ci

Tested-by: Ricardo Ribalda <ribalda@chromium.org>


On Wed, 21 Oct 2026 at 06:52, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi all,
>
> Ricardo reported an issue from moving the compiler test for '-mfentry'
> into Kconfig. In testing that patch, I noticed that the kernel.org GCC
> builds for s390 were not probing correctly for '-mfentry' support.
>
> The first patch moves the check for '-mfentry' back into Kbuild where we
> have the proper information for whether this flag is actually supported.
>
> The second patch documents the reasons for these issues for future
> travelers to hopefully avoid these problems.
>
> I plan to take this via kbuild-fixes after sufficient review/comments.
>
> ---
> Nathan Chancellor (2):
>       kbuild: Move testing of '-mfentry' back to Makefile from Kconfig
>       scripts/Kconfig.toolchain: Highlight cc-option differences between Kconfig and Kbuild
>
>  Makefile                  |  3 ++-
>  scripts/Kconfig.toolchain | 23 +++++++++++++++++++----
>  2 files changed, 21 insertions(+), 5 deletions(-)
> ---
> base-commit: 997208ce9f43f01febac956cf9aeffe89945e3c1
> change-id: 20261020-kconfig-fix-mfentry-check-50525bc5a6ca
>
> Best regards,
> --
> Cheers,
> Nathan
>


-- 
Ricardo Ribalda
