Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903967;
	b=BozPCSKXJYomrzyyLXRiZnXjkQFHxSfoYGPqlXIxcmP7TbmXw+2jpc4cBWYKMZ0UaLhD
	 Tz5BNOwmDYp9lLGC61G0ZT6kN5peMjFaSFzS0GvgMagoVuTJWef2/X/1EoPaap6hsHa4r
	 KpTEFmB3jNuCePUqXKEioFB2DY4efjnAMYiNPyRDQ67Dn9szBhqyC0zce4aS1EhvltYvg
	 UoXxyC3yZ+6hm2mphJAhPyeQht8k1N6ZQq8aKliMC932fz1IT/qZ3tFPcEiJkjlOQ5M0d
	 flr8fHqWKdKpiUJaOeLQDqb79VYRj4tyhEkmgtHizGchoEuZra49CZWXwBN7igUPuaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=;
	b=geVSOuLiVzLI4IFqy8Q6m5AgGBm4cY2Oa8Zmhb2CZdLp1OJKIykiG8yKirVIwKKSXi0B
	 2orIzncwcwfw7IXBSixqR9xIfSmt3hyDYHtc5N6dGPnqPxn+3CgQvJFdteXxv+GXN18Q6
	 afpf1eg6hSqNzqyeb9bc8Cv870NZIK3/3l4xJcLSjKuVZc2vnmuM+DcZ44ltzkFFKb/i6
	 VPbUq2x7yiPyfQEboYvCrBByCdueSVFe2RMbO3Rg0KMT2zDK5Na5yWcBJqKsquhmWtdBP
	 4fNgPb8pIrdBzsd72o286VPuDLYmcJVU6yTrVybS29Pvew87ff93NPgrYGsMHUC3iiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cds43TFp;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250AA606A33A
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 08:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 250AA606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cds43TFp
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so4353895e9.0
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 00:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794903965; x=1795508765; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=;
        b=cds43TFp7I9j7WPcDQvYfHpQ9LovbzzVif9J1GAb84gdrUsjaaD/ks8/CxWEGRZF0/
         68hyeBKuGnu6JbonI+DUrAk+S9ERoS7tOFFA4H5eAQDr7L4jclXV2ELfZ8mKm2Ufg0Vf
         wmDFKHpSFXtb9q6HdOEKHOgWOeHJI7n45fohFUmuSejGQMSPwWlozLhppiRP7NP6/RTN
         Xh3C0JkZ12tnXvLGCknth+xcOYp3m/oSfXqUlVI9cwzFe0Rue3P0S85bM03sQyFUoXwh
         8JJkMFcg0oB6zhSAQwaixAlqp7dYBZf2pow5RK/cSK97CWugz7jqMDtCMqYWg5eRSPcE
         y3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903965; x=1795508765;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=;
        b=QLfr+f6zudnICO1xaMbhAUwBsXqByucsxJjHnPjJQpah/GN4IYpqhBxG6jaysIj+R5
         ONcffc5chwXyX+mmLub07Rvc4ASUdh+zVMPiZJoY0njL80Y6aCbbhA+Ce+/c5Undw5UV
         i7cn2S9ZqppPQH2nP+gNCkjyr6Eah+lKmKTumWGUm+TQK4/ZolcdOHflfEpiBPPmu+mL
         dUyDbp3LTOjrf+wfm1cfTcDr9Oa9AcXzlX+/TiiQFUXQXWhv8nI6agfZnSf21BY6BNtP
         3Sm2wkpv67VdugFPsw4TOCmnw0ZQJPC13UBxN/n3B8guCL5Q6bkuegpGrVPROUNGtCHl
         /0Nw==
X-Forwarded-Encrypted: i=1; AL+hErEb0sALEp4B5E+fr/dgwpwSYjEXaWG86YEhQerU1rBbL1UfmFfbdElKOTdwGjWyQqpwTPK/Gl6AqBL0@vger.kernel.org
X-Gm-Message-State: APuU4Z9jXpCabwT1Hp3mKNv17tSuZh+AdaOu7aNXlSAl8wwI4MGgbYV8
	NB0SgDNamEjH1w5QRc5k4dC4PrbjgslcPH82kz97AWBFichqSAzeCv67Dmse4LdfL9cw
X-Gm-Gg: AYBFou0RS1IuHmw5jTacqvU6/D6JtC5GRnloszwoLuieS6Gen6rGPITwUk1TNhqGwES
	3k6f6BwchMqoHFL31voFv+XIf/xA/jlc8yuNuvd4AIjgQYFgo9wkU8oDCDAEuXyobITTRCp8Cw1
	IEFx0f5f9JfXxUw9JzhpFxgBTeXfkYG1cE5N9KiHZrAHcEG/0nKyeDZZSy+eKzUIYL03Khtz8gY
	VTd1TcTRFGW+wMo+AO/3UXW9QFuLXLfobXBmD9uMW961i+IyK9w8zaeImDu8lcTPjt1SUQ5INy9
	UOqqeiizPefnrcom/t8fpWxNZkg5fsdQ1MtS7UuHgZHfJziIHK1OBpSCiYe5xvo3LFkE2E7gnK0
	YVK9YJfF9/e8QFEB7nFUx/YaMH0njaGMkpNw4dWMeCMyaw0ZRfwjySE+lCaeaqX5zN8DKeNDfnn
	onL1uol+aAeW9XnwG0aEwNhNRjmMRebu3rSt4+pcjIvNbapCUfHT6WpGz56bQw1/888SSj7xW9J
	vZS9leJCrMSftOYPJY7uhS51i8tHxfEGnQamy0N8I4OT0aIZuyJYXMIX2+Uauad4qvGhv3RvP+y
	iBaQmTAgYbOSpyo4/YPW1+M8bOW4zGuy8KG7JAU+Uq3lsiuGGcyq1u3hJfbe4AXc8QpDSsfKUdM
	Z5hzO/Ja5mptm6v/PKagSU02RwWOWLiGUCOwbe0fxeQJo7yD5iFMOM+v/
X-Received: by 2002:a05:600c:5493:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4bb783813a7mr42606245e9.10.1794903965400;
        Tue, 17 Nov 2026 00:26:05 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7ad9430asm12629125e9.15.2026.11.17.00.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:26:05 -0800 (PST)
Message-ID: <88041240268f70b218de7dfd58c41977d03a60d3.camel@amutable.com>
Subject: Re: [PATCH RFC v3 03/44] target: fileio: check that the backing
 file supports ->{read,write}_iter
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
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:26:03 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-3-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-3-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> With fd_async_io=3D1 the fileio backend calls ->read_iter() and
> ->write_iter() of the backing file directly. The synchronous path
> goes
> through vfs_iter_read() and vfs_iter_write() which check for them but
> the aio path doesn't. So a backing file without them calls a NULL
> pointer on its first I/O.
>=20
> Refuse such files when configuring the device. On the synchronous
> path
> every read or write that needed the missing method failed with EINVAL
> anyway.
>=20
> Fixes: 769031c92c8b ("scsi: target: target/file: Add support of
> direct and async I/O")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/target/target_core_file.c | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/target/target_core_file.c
> b/drivers/target/target_core_file.c
> index ab9824a4852f1..a5391e57e9aa5 100644
> --- a/drivers/target/target_core_file.c
> +++ b/drivers/target/target_core_file.c
> @@ -144,6 +144,14 @@ static int fd_configure_device(struct se_device
> *dev)
> =C2=A0		goto fail;
> =C2=A0	}
> =C2=A0	fd_dev->fd_file =3D file;
> +
> +	if (!file->f_op->read_iter || !file->f_op->write_iter) {
> +		pr_err("FILEIO: %s lacks ->read_iter or -
> >write_iter\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd_dev->fd_dev_name);
> +		ret =3D -EINVAL;
> +		goto fail;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * If using a block backend with this struct file, we
> extract
> =C2=A0	 * fd_dev->fd_[block,dev]_size from struct block_device.
