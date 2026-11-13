Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573425;
	b=QslB2ofUehgT1YFQxAJ+Ui86aM4jV/MdFeqlkd3eMvIqQmeVLZ2tif7e8zQwHq6pHWkW
	 J5IH+gsBL4CCSdJ4N7I4LeOwUA7svzyTLzHjooqZsHAkRJaTbAHxDaB2ESLzIq/e33X6I
	 tVWigmXAWODGQEaLa98E37cuReWvhqirExsQm3mJsL+4V9lDWyhdykQXr86CRmNrHeF6o
	 4CECrpvZaEFSyj+1iTRkdcEQyPSdWM4Y1DtrL5eI4Zm5Aq9aTsma0nBnq3Vo66EDxPSVr
	 NYGaaUlG9IhO5QWAAzrBEFlrCl4Qf5vbU0Wbzr3acjR2yHmjUD6zQbRsnlLZvjNeaBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
	b=qETl8gmx4+OkTkT/uJb+gU3Nz3L2NW8wBbVDT4f8FDT2UlkpTJ76Yz5h/1xxLvsTPfkh
	 SD4OoQ+vOa47kO6tHSiGZDPImV0BKVVPTa4DCNILffJxOwJIOqk7CsI/4bm1qFK0PNanF
	 I2i2kfByFvmY1hRatr5cO4n4OWXhBFov7wl2nobkPIeUgyCBxZ35H2gwH8n8o1WQ7P3gP
	 BGM8z37+W9/C4M9Afh/YbHDL+FQXIDkMOO49l3HS9N7bhB1bTaLkdTZxKh9pfJ4FIhzDR
	 5AEU77ThxMAYQ1J9ObZXn1LxjQoF8a9gBl4c2N7xdemuhVfG9xxxVDXr80ishvC4FYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2XPHptJ;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC4606A32D
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 12:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8FC4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2XPHptJ
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a5f76661b5so3542005e9.0
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573423; x=1795178223; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
        b=n2XPHptJWAiGnWBjuWK6g5NkFljgiKFcabC8Vn0J/U7Rs5oCxIs8ae//bm8icbKFtW
         GhaGag1Xoi7ZyXwdHESo4gzqQGVIFHJ4SWyDVffZrMrzihrR6J8Y41NroO1pUm4S3UEM
         GevRMV87lpSFNCzDE68IInZGbL5X+gYDk7IApotAPKeUo9xOfBbHGBSC5mcggp0KJBcK
         Nc+e1mR1SmgmgC0Frha4Bk72pKDTzd14yUseYASwtvG8qZfbG+gNn4GmoQhA8ODET64L
         X6SskqZIriPJvj35d5mhI8G8hobVKdLKjnxeG6bMHAYcCPTjUD9dRkaaJK3nWVTXV/IA
         bDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573423; x=1795178223;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
        b=qcFsFm3yOLHabCDgzgzmY0Javikn99wCgqfP5FjNmWGR2c4DUqagzyETwcz1GzZVM5
         xC5mVC5K5K6Lv2/Oz1+9JFSLA0doLaiPOIy2eMf5yDqbzFdCe0pJHFDiABS9ia9//UC6
         +mwV1OM1+gooFsQHXAoRutNb/f7Vjjbgii5rjDRlBiEPiUsv9oKea42AmQkSQjxyEV99
         8fX60w69R/AqcRcVO8/c+kMGu1VrUFKGq/9Kc5jyAFc/K1ENU9WwDv2jaGRG5jhArAq0
         QJ0t03G40VFJ82zEcK31Mt3ZBS+EntWsszP+RY/8nWitbFAjEO4KwQPFt6q3aS1ZfvbH
         y2Xw==
X-Forwarded-Encrypted: i=1; AL+hErEJdpJw8ezpIRfrp3l9R5m1Blo/8uTdgb8CaE5J0/VwPAlsObjJOmRNWAegLdqAYcLNCRl/NAK94IXl@vger.kernel.org
X-Gm-Message-State: APuU4Z8x5pJTGesiNa8gJQ2KM04w35e3tm5zyAq0iK1u87zbE9/swe12
	eW0f/wU0nLd0+LnlUXQWWP5W/1lQpDE0cD/p/FrlpTx0colwRp2kKjF41sl+OLHDi9RV
X-Gm-Gg: AYBFou07Ujq6CzUDaWFebtOqDUrOqHXkU4h/eZJKzk6zKZsxUFwZ3tqRMWzXOiRaiMi
	na45gOAyp/BOlbXxivsUWoDHtIBKBRSfz0Nf6FgRgAXpGmJFzp78LdTlyiGt3yiNSnwaZw8HsFo
	jXDgn8+TW+tD/1tWl5XphYCErsbFo6xVHWXGN2qbn4BH7d5hnhY2cvbF8DOPE1vkv20GHrpvOHB
	zEHgeuYQ0T8mVFCOQsJGKQucMXT0HyMBON89xqbuNQpDn7kChFlql0Rdjl/94rjxFKI1F+7x2XF
	8qfqRJu3oMr0v2AvJmX45Li36qpxMFieydtTfdGJEdpuFtRVm0fJMmgaKH7KU1DorAvJP1qOlJ+
	Mpg++w0jqimZxGFqxd1zIkq4QJ/Y2UoJT8YqxXoOP3/J30jj0pmDJfAWeRxpHfxQVoYzUwH0ugU
	Fn0n+hV+Yd4tro89kkoe0jd5yF8+opkDqSQOkJLKhZbTxVlz0hlQkKSJM32dZaZJxUfAH2WexJn
	/w8yB75kdok9dokkNgQiOrJ1za58RFQcwVnlgPaSja7nN/0yT8y6Hsno4hnLRjUVXQZgvTK4gN4
	V4WEO+hGrTF2XeKH11hpEVvc+mRrxFL4NP926MJ1zrfbGxRgDOLOlxu//kvAX4YRD4LvxgAtRcg
	/B3rLBZoK
X-Received: by 2002:a05:600c:b86:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb55ac4030mr49782945e9.34.1794573423157;
        Fri, 13 Nov 2026 04:37:03 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2901sm57437255e9.13.2026.11.13.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:37:02 -0800 (PST)
Message-ID: <f12140be54ffc4d1e8e4026f80c41c75cf5727e0.camel@amutable.com>
Subject: Re: [PATCH RFC 39/41] usb: gadget: f_mass_storage: refuse files on
 pseudo filesystems
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 13:36:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> fsg_lun_open() takes any regular file as the backing file of a LUN.
> The
> file-storage kthread then reads and writes it with kernel_read() and
> kernel_write() on behalf of the USB host. With a procfs or sysfs file
> behind a LUN the host gets to read and write kernel interfaces with
> kernel credentials. Refuse files on pseudo filesystems just like loop
> does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/usb/gadget/function/storage_common.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/gadget/function/storage_common.c
> b/drivers/usb/gadget/function/storage_common.c
> index 75831f2c7abe..83683ade20c2 100644
> --- a/drivers/usb/gadget/function/storage_common.c
> +++ b/drivers/usb/gadget/function/storage_common.c
> @@ -211,6 +211,11 @@ int fsg_lun_open(struct fsg_lun *curlun, const
> char *filename)
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> +	if (file_is_pseudo(filp)) {
> +		LINFO(curlun, "file on a pseudo filesystem: %s\n",
> filename);
> +		goto out;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * If we can't read the file, it's no good.
> =C2=A0	 * If we can't write the file, use it read-only.
