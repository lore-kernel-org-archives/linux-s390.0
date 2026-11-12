Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500311;
	b=xjTUXn+vmV4ejHUcHloiPMc9N3FEtbhMGRM5mgB0m8ZyipEaMDsm+L51VOfsFbz/wUMH
	 5Eku4geavub8V/cfU1IDBlGj+VW3fZ4+kQ03XXdLkiejSuM7cqzKSE2RCXrBR29dQuTAK
	 3trg8TZOPUYmbFxOQPX+GKz4s6IAKZTooTscTKWjd0HBG75g38Ag1KgRzHta7kV0WAGiJ
	 UKlwrZvHqoQMPR07KkR9kJUb08FwIZXrif1QEBrnGVBuYg9aavCENGOUQHmR19m228OhF
	 EVpY0PRSAiUI8SJMH0fymuQT4BFRpuaWgqZ3VDtGGax/O79NaG02GSGGHhFKNfKU1Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=D+wwjazAct4IZB2YuQKwqi24Rar1lXO2vO79SPb/nCE=;
	b=k+Z2YnGzXPA6kpnfF718iwtDsPmZ7eYl8eTaSMFWPOlXsfJyQo6531B6IUthaQVECRZo
	 dL3x1/i1fCobeUOGhEDTM3uCJexFfiP1RhLatIK5I7npzDj+zM1u2hIL1QyP1JpeMDxSg
	 oJA1MmN5twfAfeQSuVwO/ShDi/Bi0lc+NJu4Hu6HUf82K0bMDplRKn7heMKjIrTIpXn+g
	 EbHAYDC4sw8SSAPqj69P1F3oybIfJdam9w7FOLV5ePHD9Rz6lVsHrOxJUW1zzHxi6BFLH
	 GJZOADIFzPIpqmDIH2pMa4q1mgRbBnCtzgnCtLDXW6lnilPn8OTvlTIZAch+HTPFWCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XIDnrxIo;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD91606A32A
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 16:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFD91606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XIDnrxIo
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so2492189c88.1
        for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 08:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794500309; x=1795105109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D+wwjazAct4IZB2YuQKwqi24Rar1lXO2vO79SPb/nCE=;
        b=XIDnrxIo8sdAfxBpG12mCoHmS3PnwLDutuMW741oRA+n9e4WbIIvTqMp09b9XX+s4w
         QSbiYy99el4yMTlCueAcpwrBbT1woLxB5HEXiSpt0WUh174EE8//peCgTpTg5gcQSCJX
         2Rg5y4uJVRHqrj66Qz6uqfGwI9uwy2nHgTkG8PCe2fVAZ/gY4byMVm1FEbRFDBzyC2+Z
         m6EJNf6UCceuTC3cdgeCVDtir/QZ6N3RkyZXKJz/z+zXXL5VaApjALhpCqLMF6MlG9JN
         4qkvZPUFw0v8dB0LXziaWteP82Lg6O0UINHqU+CQ7wCRfG4I4/Ms5fd/nLIXB2MF7NcZ
         nskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500309; x=1795105109;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D+wwjazAct4IZB2YuQKwqi24Rar1lXO2vO79SPb/nCE=;
        b=u+0iAWpLRlEPkgZrPUSikro8B5D//yRm1pwYQZ72P6Ic2blAg9sq1zGarJrwPmQDvC
         u7q+iy+uxAayn/734siTg4SH1ZZqSVCllVp3dGYZgl71+/44Z46CUf0f88hkB6/LjAGv
         TGV1jQE3pkgftz5qHjobBCJp7pKkqVViT4/e5EOOLWtZyW3girCxSybH9PLU2qpPksX6
         UlCENSnxcWszAmUMMHeEUJDGHuYz6BkUlTCriKtyFKWUvnmfevI7bXgLwpbOrSl2dVHj
         NJtZHU2MWC7W8dNppnuSHoIx/sP4NCv+GAtVZO9ltQktVjA7qTKdIq8NmMKxli/tkaEX
         2oLQ==
X-Forwarded-Encrypted: i=1; AL+hErHStjdWBg0ATMGpbRpLzFxNQhqui/QH2iY0HTHIrKC125RXrZlzfapwvSQe77ZumliE7XmNmbTUJwRC@vger.kernel.org
X-Gm-Message-State: APuU4Z9YG/xGb2/Pt3VpXPK2viEeuOuKAptodpOIs9FagWlLqpZAU2ic
	sPTqWhIP4MRZAdb91UTCscHdwnqJK80jJhfQE81sJOzhUXDq67FQvbT+B08jXBqNFa0=
X-Gm-Gg: AYBFou3gGo2BPBDXro4Wuj9elkDVRKBN7IfVLJ4L5/c+L+K0c5wyE+lHRDIinu9vBp4
	CZgBl2I8UsxErRxra8XFONavRxtbDgztBYNvznZnThkDOraJfHP1Az9CFIXmi1IkUoWxEhjT7vx
	+IqDPAyvVq58rMRvBm72FFU1TZjMSbn2B/j8jIY6FIfgX8bH44n5HRuqUbXA8Fi827j6OxalIqS
	ZEFts7Rt8bOZ9rOjQ0JufiyMoP1wu9AVL3QFHtD6Aeqlc5g4u6eUNdN+z5Z4NRGVvl5KZjC9SNq
	26Xh5DS1YZW8RJarYfRIi0Cpe1h4t28lLgEejyMplBLdkEjX3NtrGTxAqbfBOKG+lP3VSLLM/Df
	TQ8xhW7JjRDS4XzkK0lDeet0AdnpK97QkqxsABzdajg02HMdi3uSDD6ESY2k4VnU99b0m17lue0
	kuy1e9l2hqWTZr1oVzae86v44c2Q9m1PAg25j++/nB8ddAtfWUN5Ng7O39KE40Bi9DrALz4mzBK
	j5fgrG7othBwqTKBDufECSYgJVgwI4dPKLRkrnN6vkKLU7ygh/pL8LcuNeQ+tpP/GPOuKoMwBDK
	cLK+ToeIZmqBesLXheEEa5H2la2Wcl5fvYgeFGwMOj8BFGRaBCecnYOZCUFm10BGNHjsRbsCqBL
	nd7jLi0RbH90DcTwL1IM+VPpBROPaUXUZQg==
X-Received: by 2002:a05:701b:4554:10b0:19b:39f4:88c9 with SMTP id a92af1059eb24-1b503115701mr40021c88.10.1794500308848;
        Thu, 12 Nov 2026 08:18:28 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm63092c88.9.2026.11.12.08.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:18:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261112102608.1057852-1-sth@linux.ibm.com>
References: <20261112102608.1057852-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/4] s390/dasd: fixes for RCD retry and BIODASDCHECKFMT
Message-Id: <179450030814.6809.12199806849669724692.b4-ty@b4>
Date: Thu, 12 Nov 2026 09:18:28 -0700
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 12 Nov 2026 11:26:04 +0100, Stefan Haberland wrote:
> please apply the following DASD fixes.
> 
>  - Re-initialize the RCD buffer magic "V1.0" before every start of the
>    request to fix a condition where z/VM omitted the UIT and the paths
>    were wrongly reported as leading to different devices.
>  - Two fixes for the BIODASDCHECKFMT ioctl, both reported by Sashiko:
>    a wrong free plus a refcount leak in the dasd_eckd_build_check_tcw()
>    error path, and an info leak caused by trusting the userspace-supplied
>    result field.
>  - A typo fix in a function name, dasd_sleep_on_immediatly(). It is a
>    prerequisite for the RCD patch.
> 
> [...]

Applied, thanks!

[1/4] s390/dasd: Fix typo 'immediatly' -> 'immediately'
      commit: ae6f19236b5ae4eef4df2780d51bee19add0eba8
[2/4] s390/dasd: Re-initialize RCD buffer with "V1.0" before every start
      commit: 25cdc1f63227a1ea69a1ec823a8a860e33299169
[3/4] s390/dasd: Fix wrong free and refcount leak in build_check_tcw error path
      commit: df56f7a6c20a5eb2794c0a7391bde50ba7c8c54b
[4/4] s390/dasd: Don't trust userspace-supplied result field in format check
      commit: 7cc2dda4f7aaf596c1796184649007151ff98f8d

Best regards,
-- 
Jens Axboe



