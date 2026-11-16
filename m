Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794859451;
	b=EHWg/P+9vo6QRipWpIlBJY4+qFzgEToY5TAtnZ9Vy5Q2SvEuoWDj7mZbTFEAnW6dv8wY
	 Yv5EUYnhOBqrUXAsRWUZbCzoa4wcZzOkoSkciLCT80ddZlHgJ17cPRu+gaibQJh3Pphf8
	 n1QnP513dUj+71NdDAzHs6GO8RmCtKVI995lDrzrosNWJJUhG7KZiuhfaG8LkYMw/ksyr
	 SXuJu/5Pm95jAnksN/o4SedMPgwIX4c8SA7pz/FgC6Hvg+uFl8atr42dCAgMks385eaSC
	 gf8XPw1tlLjvubRypctjlN+Mf7EEuSIDP8jBTlR9CVKDErQZAVuJ2Rr3O/fao7zEmqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
	b=mMbxodP7Cc0Yaci23vIs3gkqhAvM56R1OeDdFjIcS1HMriFIeyd+PyXVz1IqFKsToxm8
	 /BE3skY1JkcTMkyI18KoVC5EvtbGUWF0n7AErUO/+YT1Ud07M3Cd5U/UladzByGI0oY5z
	 Arb1Tt3hX7j4i08rD7KtjVnrm+5oQdz/0EkqE3r574Rdvx85MfIR0z9FakHZOwmylw8kS
	 SXR+PbjJtW1fjC9AtTm06uEUtJHoxKN9dDXequsbww0MAsYLTHuulCe1y1UssZg5Rro/+
	 ZF4H2VzvrNyfQtwAlH9t610RrGKnDkgDZEHXXNJKJjChdFmX/m+Q8dODCxWInegTnVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnqDx80H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA8D606A329
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 20:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DA8D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnqDx80H
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e47347279so1838153f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 12:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794859448; cv=none;
        d=google.com; s=arc-20260327;
        b=J0iTYusFDwxmcVzqsqSkUH+Y6Sc6bIVd8U8I/w6QQMy3TIad6rnbPBItLjAGo5v6Yt
         cHTLZT20I2w4zS4ku5pWZDWXFlTE9sxkzZhjMVEtiDav0RiY+s3e3l0sV4ksQDJOKI/e
         w6G++w27m9M30hN37Trwypas5OOh2o5W1BffvIMl7KbOI+o//ESWnq4XMhZVLRp47f0M
         7pK9QfJDvlqVza6lLH2Jpzcs1PaE1XCvQ3ssn2LeVJpDpWBeoOh4NUjzUNlq4YKBRL+j
         PI43ENFE/Y15yWRqDTzXFaUI6E//A9nytOPQcS1sfvtLup6Oj6mb1n2vewAECFs4odOM
         PeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        fh=KXo791TrhRnp4FFqJBpKwjUUq39XFGavnP0MAzIZEAg=;
        b=IU4CSXxfwcnjyJCESecvH5+ba+3S84NZG8Z53rHz8+2dOkhu3O5VKqe22bVxkForD4
         fHa2dB7q5M/D2nGMrturEI/b1jKAxuzk71tozZis4h5q137cOUggmvg1JlM7cYH5MVLn
         yWhs51Gjw4f16UQZx2UEraSqDRoXQJYygb1RLMhpYXoc/Ve/Em/vKSlG0iVNEJ86S4WO
         yBY8iTCYbxvQimmEOjygx0aXvuFWuPdhIpq1eVr8ca8wNuO6YJZZ7Sxt3MGHGQklyJuF
         vZw8Xb6rSdVGHuRPBl/uBgSKncYnvI3qvijolMxtDfQIQuDyPAHgkbA7VCTZmQ0XF/o+
         jXkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859448; x=1795464248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=hnqDx80H1BHGMZ+jCw863LQE2wm4hG6wTw//ziQNWkZpZIjdyNNCtFJNcbykSvuJWZ
         RrqgQGru9l+9Rlw9NCoAO7RXSeH6CHzRwb+h6TsbT77V+vTLtC7o5AslWzWJ8+7yhciq
         sbJxN7Yoz6y6VYO91QUyEDVlXVHt5e/uzOZriYhKEljZIduQH6pNfhdOY5sHlJFueOxf
         bN/uTLfuNBjnHaTZ+WukZQS/Wa30tWyiKsfqEPmOKtkcPCgN1gGIeLsa9pfco/3ZvP3P
         koo3Bb9/+esUnHdHS2hTd5qtXE/k/xctadMJUuU/zchcL0VDKvTRNofZgdIQ6mLOou9W
         X5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859448; x=1795464248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=0/IVW9qJfsX4R05JAJQ5CY3Z75rFBdHNvL223SXfZBgvF245pwGSmxkyklYqOzW8XM
         0cXIqmuV52FTszhMeKBCLP418v+ygwrDSINsAuM/In1Kw7NWMmrrpPffmxNrN975/A+I
         92Vu9ZtnRlO96bs5S6LCWpKewWHBHAMeaeY8BBZb6P5ibtFhxcV09R6lxtm4Hjf8Z5ZN
         Qan0xYxZDNevGnQQCxLIL1rdhq12Q0BjCAKZEAXyJRHlWJ2cW+SUOytqsOAPzczPBJ8p
         1E/mfildU+K/y73PncNb5N6572gvap4T6ONhIP56XGQDBEIcDkWJPzsOqLn4mYQ7Q66N
         sR8A==
X-Forwarded-Encrypted: i=1; AL+hErE4TkmW6yNw4Mxow6YDxTd+F2mHQnKQVoeSQ+dXUFDUdDvx/3VproVGQEBOAL6AuMSkA12X6DAMDM7c@vger.kernel.org
X-Gm-Message-State: APuU4Z/Q/vKarcv6U5QPBV6phPnL1lZCfU7I2bABXz02lT6/BrlIwtw3
	X5qT+IvXMGqKAIAmVv08c7083VMFGK7bJqEmDqTkoeCsZxxtXt0K4UfMUEzbS4yzgO8gXwz94g0
	7AXT+SFHyn8BtBVLE6zlGcHXOOCp03j8=
X-Gm-Gg: AZFdTZd+UoDY7/DpdOyR8QRdhkqdD+layu2lgoa7TRIxHM3MmInUY+hRsHBcme7zod9
	jo004KPYi9nkm78wo/bA2sO8G1GknCh6W2vsR3U7OSzsVmF6SqEHOTCHakgnHI2nY8dU+50l6/V
	xY9HnV3XFwmjwrvJkm+2EmJIQ7eyejnxdWf/Q5tPGM8eql9imm2qmVPzDxXuiHsYBsQbGmLRRzc
	y6Ubd7iYNgh/Osyp97ATQ1SIbp7ny2KMpkOgaK1yYQAnnNpbo+gklFcBzPTzUZeGd0yp/ClcuNj
	ELbzvyEKWgefnU6YkWBsxnhHUBexSI6j3j7YNy17tMnc5IRD0xZYFXVpreCtKrKuHvE7/mQ4G8s
	wXNig5AQP+xOL85IsXZRLiTnjSs0Nj0XusmMk93/kL9P4JQZIqG8NwprDp+Ccr1ni2v++tkh6qP
	YPHave7Itg0mvRqlisgzA=
X-Received: by 2002:a05:6000:4692:b0:491:3fdd:af34 with SMTP id
 ffacd0b85a97d-49d61c80db3mr13343868f8f.36.1794859448335; Mon, 16 Nov 2026
 12:04:08 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 12:03:57 -0800
X-Gm-Features: Aa3M54q6P4M0RFDCKQ8HHGNCWJafItTSPdWR1qNwVGtToDAv2VOv8vDfWHzYR6A
Message-ID: <CAEf4BzbLFVawibuX0wk=8uzy0WZSYHbkgK55d7rqLab2qAM1Fg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 09/44] bpf: use fc_init_pseudo() for bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
	Alexander Mikhalitsyn <alex@amutable.com>, Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 3:21=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  kernel/bpf/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e1..57cf3775c0766 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
>  #include <linux/namei.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/fs_parser.h>
>  #include <linux/kdev_t.h>
>  #include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block *sb, s=
truct fs_context *fc)
>         sb->s_magic =3D BPF_FS_MAGIC;
>         sb->s_op =3D &bpf_super_ops;
>         sb->s_xattr =3D bpf_fs_xattr_handlers;
> -       sb->s_iflags |=3D SB_I_NOEXEC;
> -       sb->s_iflags |=3D SB_I_NODEV;
>         sb->s_time_gran =3D 1;
>
>         inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct fs_context *f=
c)
>         opts->delegate_attachs =3D 0;
>
>         fc->s_fs_info =3D opts;
> +       fc_init_pseudo(fc);
>         fc->ops =3D &bpf_context_ops;
>         return 0;
>  }
>
> --
> 2.53.0
>
>
