Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830458;
	b=KQxkNGw/GuqTZlswaUEoDCBAUgddwsAGJRGzK0dMPsxb6xZJixNHnQSQDZmpLzSNcjNb
	 FofjSwbmU1nW3Ohh1O9mJsUy8QGR9Twdb8REkdszF+tgXnXVcHLyvHabY7/3nti7WaUWB
	 ptlxCY7j8ZRklGA8hSmkQ7DRh2oHgJdDX5VAHV6XlMwMDJFnJ6N2ejOmzu6Vtbg11PZob
	 GKj5+9jz8aNdx8BBHgI0IbuyKM7+qJkelgMF2papFAUvwtUmwuWazwOidUrvkPsMWKNVK
	 NejEx+AGT5Qj4F91bT7Q08XEG5ifURtEGZjdaO1JSKsrXIX5e/S1WQUGpG/79edap3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=;
	b=iiVGdToUQNVLBd3bW8+OJbT6KyjDrV9rsyGQnlJ3je9c71idiTgIFxjOdVL5WTAPGN4f
	 pQFjaigQ2DrNQ1Lf1srKGUHyEU/gAZ9tAOaJkdF1NQom3J3ZcnPO0A7UP4VmR2rQc1h7R
	 Sx1T0YDKJ7H2c0tGEfvk9e9ZWkMsgX+jSwssWDoGJUqA40qSWF0UmtXrzMMNs17C89F14
	 SN7IUTTxjhm4N0uDzZK52IoyAkE3MnR5L0yhBTb0CSDqXFkVaUtaHcXmVyXVKOnHJVnj2
	 jN/GSw3igbmsa+JwIWgUkIiTV9/Z/mONsRqqUlWZb/ZlrnYIv/RO3jAaT4I3hKFDE/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HPhDK7mh;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4D606A330
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 12:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F4D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HPhDK7mh
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4923b9fdd43so2415779f8f.3
        for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 04:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794830456; x=1795435256; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=;
        b=HPhDK7mhvKoexu3wV/J5cAKBVCjdxnE0WqiM219E8yH7eWl2bpFOUxbsfidw15OaBQ
         3v/oOiLCUqOJKC7nE/sfeHMGODuUIsJx0HNirhnEfTrkTSlF6mxsAka4bN3HHTEKuz8X
         I7ILCePljUvo3TBsSDLONNTI31MYsfntJafmj4EM/wfNH8zBljPNWXbjdXsxXgFWpxK7
         QBsjZgUghWzTrvW3gB62VO1cEaBa05GYc2ZRtlRGIidAi9COFMIabjVojBmfGFLgZQra
         H+ROglAj/Ny78kycfy7M7MzfDC6v9ICyF5eD9XUlfn5SvIi4OODpHA/Ny8dfvpbuHFYW
         7n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830456; x=1795435256;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=;
        b=XtM0Nq7BVQdlZhK2eFImepT7R44Fog5xRJXi/CTBW9GxflYMkUiFz7zUukBKFRIkba
         Zjyjq+WAOS42qdmA2DCKDcdHaW/vSl94w6wZiok+wZI8UUEfWQul+dRt1xco+qwYEctU
         n1PG+ihGXg6fxYX9wLVzjt669zNLh6NYLibIGJ+jXljkgi4Fq7iG9B7DD0MFT8FWgTwx
         MryMXZeXTGQCg26brwwYYHddnpgMqKnrl9vslnIb9EBWtMYYguh+D9k2bXNHdjlvCw/b
         sFFeo4/EzTGjRjezkETt8i4UCRsV8X0wMRpzxakSYeKIY8z8uisGx6rW6ytz+MK3Lj5m
         xsYg==
X-Forwarded-Encrypted: i=1; AL+hErHh/7zKyiZm/VCAGHG6cpMafpHcScRcGaYw1YTL+ccq+IjVMaNoiAKu08B66dYjxv4/G0hh7LcGBiMS@vger.kernel.org
X-Gm-Message-State: APuU4Z+fqvvU3H6esMpShWeAspRb6EL4qfMz4cX9FPURmGliIsbSaG/Q
	KKMTvBe4At21aIYdwk5QTSyuhfxDE1a3rrqBdjXuAB0QTLfJ83o8+5+o+cIxrm2JqDNu5f3dA3C
	xl27g9pXtI0+hJQayVg==
X-Received: from wrso13.prod.google.com ([2002:a5d:474d:0:b0:493:3d97:6e88])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e007:0:20b0:48e:3697:708d with SMTP id ffacd0b85a97d-49c70ed8e41mr16698595f8f.12.1794830455230;
 Mon, 16 Nov 2026 04:00:55 -0800 (PST)
Date: Mon, 16 Nov 2026 12:00:53 +0000
In-Reply-To: <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116120053.371591-1-aliceryhl@google.com>
Subject: Re: [PATCH RFC v3 12/44] rust_binderfs: use fc_init_pseudo()
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 16, 2026 at 12:04:45PM +0100, Christian Brauner wrote:
> Initialize binderfs as a pseudo filesystem instead of raising SB_I_NOEXEC
> by hand. This adds SB_I_PSEUDO. binderfs_fill_super() keeps clearing
> SB_I_NODEV for the binder device nodes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
