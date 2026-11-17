Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904321;
	b=3EyfQJsWnzauUOSBX2qPrYvCOqBoRA8+cjQy6t0JzGPZDQXI8u6JPOsEGiuwzKZeLZdd
	 y+mh8/2snKzNETFb1T3jo5Hkg9laAFfeN+QSSE7CPBOgYb1r1CLPTqGTg2R28AOv3+JPq
	 XAfKgxZOZWivBTLDJYuqOASq1OoTyXX4g2k1Lw0eWDrkxl7MQlMouSVjBmly8KxF4Tz1v
	 U/YxjZ+Xl6ClR42jIRLKKSbXVXGRRNbip0FvJb6BypKZf0phc865Rq0ob6nROioDx2nxz
	 bBrM3ACBydJcXGlYGBkEbuKeVIbfZsVqLbSsCuBlSMyOhX7oj+09Z6KsDDAntwkmi6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
	b=HJYGj9c1N0VXpAYUD193zd7Nn73AWm30HzuCnWgoXZXpVfxmt0wilfOqcWqsPA89DoDp
	 eO3OINBTXlZ1yUrkhqAOrNAQnuq1apX2NtSKEk/GsnctrP8CaWEDncmp7af62RxFGiKpR
	 dqg+iv78nq47FOJ2PWdUi3CNjbGTAnXvbkDjMH9DF/JhThmn/GSJP4eZS03RduksC0AJC
	 FpekcQcyONEe1AfXaiC/BeIN59QFg1N37hfhl+6hBSUoktskz4mTFe+49DirgcRPD7dGs
	 VekmDAmwbBciQGpCzdbYSi6io8U8NFi0k8t4WmGyfnVqrcwus4Jy3MafDE/H2qburTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hssiyCS3;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F8606A886
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 08:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A01F8606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hssiyCS3
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-491d1f66968so669630f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 00:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904311; x=1795509111; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=hssiyCS3YY/XlkkBIjn4Gbn4p7nDns5oVKNHEvU57RzH1EmxdJvbr7UH+8jLSstxu5
         SxYGUnoQZSYomgLxQde2EbWXVzMZqX/YKxeG7tp97MPGJ1Ximp4K9c9JECjpjPLovu68
         Ap7YoGwIB8ijgvRwO5rUP0O61jx2iWeSiI+muJn6FxVEVyQR1qVohlJsGeWPYFwVqQiv
         dm3tFFEqC+1f4TvKDqkyNAiHAdAdNNkQzS1YDMXFifAFlG5bZ1f9JrnEFag64li8yB6k
         yVbXOJEZW7tKelFKfAaf2YedlBzLumYcFjuJR5g+GmzgvSeCw27t/fCZLXSSN/aWl9bl
         gSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904311; x=1795509111;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=vyzMvhiOFXvMTaXHJ/XrDTwudBsMG0MnnD8q8mSo72tbl7/02xTa64C9u6gFDmFYHN
         k2PsiN6eMVG/fdylViGk3ley9hoXvAdzE1MTM7+OKVb6rxLjk43SpleSbr3ZAh7vQ5tp
         lJUypOsJul3WAAY70pWS2eUOjjNG1E36JyLS/S7At5pkvYJiQKUJ0l77116mc/+zTW0A
         URVC/fqBuWaq54hAEZLPm/CME6lGirSigrKI0a0Khq82ZIFZY1vHlr2icJ+77akoFqYY
         dy4m84jjt7mWgd/niHXhrVPEF9qnvomTFWp/qFoaOvozsI1FvWGt42f7FC5llR8PYiS+
         qsrA==
X-Forwarded-Encrypted: i=1; AL+hErH9lCl+NZeaIjqXxE+uHyT90f8svwWUXOKfBp5GSaL2m5kSR4KhcJD81YWW5I34qLVnhbOJGmHoba7S@vger.kernel.org
X-Gm-Message-State: APuU4Z8uCMM07eqQHm1fQC4JSrfTw93YZOsyRHzBX/kEbuK24dQZ7RrH
	j1ewvwKBWRstxFAB3/QDnZCtQTBrhWq3SFc77cQaJdDRDe4cyvj5T6YjjTms6q3ITMjm3GEbbsm
	EFdyuDcrR
X-Gm-Gg: AZFdTZdUCAlbx4wxVu9zE+B3RhROx7yRufoT3ZI+DKUbkmcKnnB/tohZ6T4pYdttcNk
	VHFBT7KvFTRGhTmcHzOFnlvYwaM/4iwREMwxRzvtLR7MEMkEvzt2icGfMv68Eef5/FuUhbPZ8rr
	suXE3McOIeNabptNHSqgW8j2WFr1gf6HVeI/UNyMpqVf42IQ4RDa/Hl6tUGlpF3pn0w0pUx9TAI
	rRdBlDCVFmoLmD9ACrczShkG7OEZXFBkUuCs0D/Xel613t3LL6eMv5AaQ12pHdcUhOdfYR6iquH
	iIgbjr0LGQGTLn187T3w/qyE9sTze4AivyPRUFE/bw0wMGWxm0OBFS+/eaXld2dFbpjCw+zjIzQ
	9raTM4AGxLXBijxXuIAa+XHnxq5IYLoTHJLEJK7SqdSHx4dfjArS1RjP6DR7VuQDWoLv0iu8pvj
	x4DUxY0Z4XCPczNHeSdSsZikOwLMBAtVxtuxiiG1iUt5oaNuUxqaN7ThlkClxkq/eyWIMsxpfHj
	ONPZpFljpuBpvuaKghoIfGcFcEbjvhL8mPUin4oX3JmymtN1xiDX5njmXJQA8pT76JY+VibmMpu
	K9u7ZadIvK1H0R/SMHA1kJFZuIpaKl3BRpOkM2PYZAOpiepEsqlipmUz9stQcTXc+3x/EKKNH/b
	7eQQS4k/v313JVEnOHhXHlSuwB60NyBUWrCRHgx0UrbMOH4KVDO/xhOkMGBoNgoknpnF0D0xfep
	vlsQ==
X-Received: by 2002:a05:6000:2084:b0:492:46e:d4ce with SMTP id ffacd0b85a97d-49c6fd932c8mr25238543f8f.13.1794903938925;
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm26907832f8f.28.2026.11.17.00.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Message-ID: <a9124bf1c858cef3e8ac06b1b2396dcb0e19e2a5.camel@amutable.com>
Subject: Re: [PATCH RFC v3 02/44] nvmet: check that the file backend
 supports ->{read,write}_iter
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
Date: Tue, 17 Nov 2026 09:25:36 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
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
> The file backend calls ->read_iter() and ->write_iter() of the
> backing
> file directly but never checks that they exist. Everything that isn't
> a
> block device ends up in the file backend. So a namespace pointing to
> a
> file without them calls a NULL pointer on its first I/O. Only
> buffered_io=3D1 gets that far as the O_DIRECT open fails for such
> files.
>=20
> Refuse them when the namespace is enabled the same way zloop does
> since
> commit 0c10f8a1a7ae ("zloop: check that the zone backing file support
> ->{read,write}_iter").
>=20
> Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/nvme/target/io-cmd-file.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/nvme/target/io-cmd-file.c
> b/drivers/nvme/target/io-cmd-file.c
> index 695963dd932ee..dfa8aa46188c8 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -47,6 +47,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> +	if (!ns->file->f_op->read_iter || !ns->file->f_op-
> >write_iter) {
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +
> =C2=A0	nvmet_file_ns_revalidate(ns);
> =C2=A0
> =C2=A0	/*
