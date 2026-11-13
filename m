Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564206;
	b=Y85HzHbiPajKbQnevKGXUPLHcHkP0JkK9wEan2Vv6TcXEIS/WFUKMyKnrBrqeY5pGncm
	 aNJk6ILQJgg0uPcrTLxoVeok1n9WXqXus6POXevK0OM3PRQzoy0BasROK4DlEnns3XodS
	 JOH80zbu+Qe79UcU4zDy9ndwTiLkQJ9w/H2oNEKwSDw7Mb5Lh0lzPs/rwXtZKmsBBEOeX
	 lVZcGBwhEyEaJX3mOCn1zxTpBH08HfDRb/JhK24A1yC/dbUOGyKKfiW6OvnlWgsTl0bN8
	 V3pIht7X7eDDiYsP7PT0Mfa/CXCEQibhVaJm6JTfnjqOD50xBmuDhVu6CGilN4v7HGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=yP9dZgkD4P/bNBFnmHOgKVBIpz9VJZUP73dl9853V04=;
	b=ZZrgxxDU9ytCDGYRBkYbFK/oPCqUL0QzF6wdrnk9x9jas59VO8UqT59f4kuSSRX3OYsP
	 LSu3Md1scJVtx5NWm5xQ9vaH9FPihKWyOKFCs5fYoCHxXmlRyi3WOu7Nl2KBnRRhowicQ
	 +BPLr2eYveUNr2V1chMnjgQVArz/FuQ5r2ejYXGiKC2w6NqUEy3Bk8VL69pwtAKf1o3IP
	 F/jQkZMP0mZZ5Cx3g7V+mnxRRG478HykgL9+PIb8AaEad+L4fcrFl4xTDFLtCAXzuO4d+
	 +lpKJsdEG+C959ivsvWhqMB1SMvfRLYDBzITYdf0VtaWNHtu44QQEXihiL6kJspN5jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gwzE4vcd;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E260A260B
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB9E260A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gwzE4vcd
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so1060626a12.1
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564204; x=1795169004; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yP9dZgkD4P/bNBFnmHOgKVBIpz9VJZUP73dl9853V04=;
        b=gwzE4vcdu75novdCBouGsk6add5G1MbU4rjoUAUKLfhHjN16JXpL3TW62te0KeNQ4h
         CFkYIh/ZmfunLC+OqOwxPpTEErLMClrM1fcYGPQemfzJ8eoNcG0IRaMTNTZVl4uFMmTY
         NY1KgETdjv8quXYbE0ixE9wDZSzgcrDYvO5KUD1dPMwQkdJqOZ2wE5l6rVs/yjm1Qi5n
         44DBR0sdjAGKBFCF4ajO9UcYXSr02RfqiQv/3Y8VdogG9ka76OpTkDSlKx1J0txrvJw5
         RvPlb1UdQfd5RzPQ+F4LJqddQeogWrPEdkR1aa5XunF4ZwrUyeTcEOKG0iN98ugSQ46P
         5SDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564204; x=1795169004;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yP9dZgkD4P/bNBFnmHOgKVBIpz9VJZUP73dl9853V04=;
        b=AXxGEKV+LMSJHr4kwEXlcYwmaZpDnSl50Py/bAf454XZrvtSEVfEW7pAqpPyuqw2EC
         Ed2uWN6CXDtH5xWdHCDly5ni6g8YTsCPztTS6gAT5beddKmsKjRY5Lx1wNxRQDJTAR0F
         T7bGhXl9iB9LQsyfKMDsw0kGDGr30/FLE7DBqfLrKztSbQV5/v9yeer6zqih7GqTr3kj
         ArAQqWHaET9itAImCqIHCxBn6Ms3m55Ua3BfKBPzLqoat9AQRdkqQ7ai+x+Yzwosbsdx
         GfvWob+8gBVEmonKs3x3Qh1DcC+cD0iDHix0RQ4WOEg3VZj6+89UUZwmL4XkukfJBL0t
         xN1Q==
X-Forwarded-Encrypted: i=1; AL+hErGka8l6WhdrvhrAsfKUF+yfLA6RdPiBYlZ768i5poE4cZjz/NPXJueymmxjwOC6zDBdrPRw9oSN4Vk8@vger.kernel.org
X-Gm-Message-State: APuU4Z+6btJ597AYcuDNaQUsMKMcPknbNAXRpGF5xQ/M/28vzffD+p7y
	DoycSeiqXVPbLUKhTP2X/vHKdTqVT/zVVvuT6GdvwpYnDUQG/MaBTRqcCEeEM7ze1+Jz
X-Gm-Gg: AYBFou0HmPdJv1bPD0/Dgc7afR6R9JSV5MTIvdnB/O0v8QfOfJWLeUQ4+hVPrOSGbbj
	/rQZLBa4Y4Qg5myZep60TOTgqy6QKCOQXP0dJDzdVNmP1CdzMazeMJqDZJjJ3m9H0+Uxs3iBoED
	c5+1Z7ulAdy1FsnmCBbmMez4/CZo2VERuu2g2X258Ms+X7T+bjJuKtPeTwSA7JTSht/jsWxW7mU
	wjqUFO7UWcUC9V3OB68kTLMsu5Mqr0Nxwgpxa1y1OELYU8Dm6ccTXnZbF0tZeyZup+MgYCxU+cM
	wSpHuZlsMMj3Yoy/giAAskv7O03cyzZ09vDnAWfKlwr7YEBwERr4UPUcF9FnIHiXPFhxi7rtN2g
	EDtJLyOG+t+gazUfPyab3cp76/UFvDJMCT9B12wZfczXYoX3vYS4i3QsTB5jv/lvcaaH9JhhbdM
	D2+RFoxBlM9agEB5MCNpK/FQeOtah/XAoKw7+eV4NF576wTfvU3q5sYdlCrcpt8InZZpTY8pCPi
	OpjCTuEU36jLHVigzNKPfLLWB2qfxVLSXMraAu4dKsE1YJ7O+fnmRAh94JaO1bRkna5wJmL7Klb
	HC6f0Al3PzR8ngfq1IjxA8nEQLJPvpLeJoXz1vbM1j8I4AhTOdFtRlrsY4L0qcE=
X-Received: by 2002:a05:6402:270d:b0:6b7:d479:654a with SMTP id 4fb4d7f45d1cf-6b7d47965e6mr298323a12.36.1794564203570;
        Fri, 13 Nov 2026 02:03:23 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c236124esm752333a12.6.2026.11.13.02.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:22 -0800 (PST)
Message-ID: <e5f36cc53b733383ac1d1f1e8c03f73091595edf.camel@amutable.com>
Subject: Re: [PATCH RFC 08/41] mqueue: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:03:20 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-8-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-8-4c998976c6c7@kernel.org>
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
> Initialize mqueue as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0ipc/mqueue.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 322c3dd98c44..8bbe32d0881f 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/file.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/sysctl.h>
> =C2=A0#include <linux/poll.h>
> @@ -405,7 +406,6 @@ static int mqueue_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	struct inode *inode;
> =C2=A0	struct ipc_namespace *ns =3D sb->s_fs_info;
> =C2=A0
> -	sb->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> =C2=A0	sb->s_blocksize =3D PAGE_SIZE;
> =C2=A0	sb->s_blocksize_bits =3D PAGE_SHIFT;
> =C2=A0	sb->s_magic =3D MQUEUE_MAGIC;
> @@ -457,6 +457,7 @@ static int mqueue_init_fs_context(struct
> fs_context *fc)
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(ctx->ipc_ns->user_ns);
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &mqueue_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
