Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686762;
	b=Lqy+sOmrMvN4Q0M0r2NMiV2KjwBOatnW+NwDHuaj3p0kKdoT4wZN926S6Xto2onBon0F
	 NoMdl495asGNVpYPsu4kJThlIClQHxabV/R/JgAl2IJNd67KfTGIZaUYARGcg7nujGycv
	 o9zcYhoZLqyEny0w1UnZObMarUB7oLnxhmpG3F65pzOxTAxFgoF9UDojfBfUgE5fTx4Br
	 Ll0GviGypzXu08hEcTjbodRulqmVuzICz8398V9XfIw3eZVpjlCHRh7JyL2F5NWQj4BOx
	 rHIBeYTg3/bEk1HP55jecew1bOLxa+WJHj3lWHFq9112SgkxgVJS08joBudaHppVYZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
	b=V9S0VIC+78G94Ztufk7dm4q7KLVyfpX59UTxbA3Cgv6yQzpsgZq7JN6BDgy3QCwPEXjp
	 gJiUai/Yu2yajQvpellUSjntMiK6QlgjwFXg2YPSGpvjYUalFjP+cvqCgfRuRfnQmXbww
	 ImWSeZfjNFNn7rJQxWUH00TbaGhx0MUIeLmgMQfNj1lrwTbHm5LcTZagjEG+DfMiQdHhp
	 2ymW89Za3QBPOicFYOcJ4JvSzafHNFwtJ7DDNwELi2gd3SZ7NZDX6zcWvQlR9M2blyhhk
	 37zjfn3bSU8jDQDvjuvHyApL8GZ8P37FNsK8EAcTKNCzUwQtSaz/hzo1QjCoi2F8FZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=WyNKKpAN;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAAA606A8BF
	for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 20:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FAAA606A8BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=WyNKKpAN
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b37951a397so307913a91.0
        for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 12:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686761; x=1795291561; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=WyNKKpANsG5sdrHWGAt+Y38DvSIGt+WnCUyNYCZoBM4YbSq3wCVAHI95jQ8BFTGgLn
         +vM7af/q0i5zrzjZXXnriwzXN4L/RbeBg/iztvO0eyeIXYNiQp/OYlS5LD9yZqr2gKgm
         1I+5A88e/cV4J0nLZfgp0f7sQwj9jY0Q4quBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686761; x=1795291561;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=r3rudBB+2wZSeQxXSIaEsRxOyk+KqJn47sw1DrfZVsThMNBgSo6TncY3FkB97Nc7a5
         TvIa6ta7LPC+otHpgmO+EMnk1ib/7FoibRT0DuTcZkLexl/ZAf6ykwvDNWDyHARdL2Sl
         fVK0FPEieBsejQ1qzZ2WE+9Wq/ayO+KOnAnLdHDK5tXOWVs2qXWCuhW0NhBmtBpGZD1f
         k9ni84aUnpy4CjDOFqlUpYs2h8WS7b8lvQFtFA+lAgztLneCP+BRAkUWWboHeZDctaiv
         Zll8YWCMMYT3n0Vky8AmxZk4TOis8tt3lCRnFn7Rm7K9VXUrEqCyP8T+eewEXBsd1+f5
         85LA==
X-Forwarded-Encrypted: i=1; AL+hErHK6ggdiZCK38KCM7WHEIBou35Y3OaDAC0zcxpdhXOklp2irXyQ1JQ0VW3Ke4nqPtYkTXl7nBor57oN@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ze/uOnyrXzhKs4kXJW+jpyaxuzNccUswF3bfHmalwdxjFKexl
	iF0EcEgZdSb+6KcP1a+vbIPukjfqMszmBXLNE/7ye1xpHjS/7aBzw7nSLNu1NYPB6bs=
X-Gm-Gg: AYBFou0HG2vHqaMlUpfUHoIQAsj2AQDHt+ml9et8U+d8suITrrLFBcMg9TUSz45dYWD
	HWBFmzy2R2fO0i6FajANmW1oufdPAh0AJ0Ciy2/4DhwhKUkDsweh6qiZ0Y/30+lAXVkLCHNy+nt
	9icy0rtiQxbYy5no1sPDFOpEia3dcCszlznILQvrmnksZIWciwr7S3bIiBXbamliS3oMpQQbRhp
	08SLy5nZycy+dHeusheZPVlYVMzqPC6mE+KG0UI2d/vQvW4iYPvutccPzU5/RViX/EVn3v0Ss4a
	yhonr+BLzap4Jkj3OdpYJT1dLT0jhybFMWUwDIXISjO60MGnuHzz4breDxlUEgW9oA+9S4iND3s
	6QYZDVEy637AH1gxZWztxbCNGE3LSUZCSr+YBQudDr1ovTWxp97VWJnMIsvsz/KsAMApqqN0/sD
	7BuO10KTLY3yESqiGxk0cSoudqSjiLX4jGyQK1164gbnKDJaK7plYfLr246gmvXaH/PM07ozujV
	HyuSzv0Mpp7qUGiTunKQAHz21ANG/GAs+mW7PdECuYszlUSqOfX/L89PPlAIypOFiT2yFu7fV8y
	xQh38ajhZZ1pLeEASRNrx9njSNiOw55sb2LuRUPKSenKtq/fVwXdyU+HuEiVWoRfC0mPusYAfx5
	sVhXiF6eBuwYqfpI8RBtfXBPeDBmJNJZ3TOQlkUiDUCA8KLgClWr5gNIMizmMNh36fodvV4IFoc
	E/SLFFdUjCZSi2w/Bnj2LHrMzHPWB+oiqyR+txpiW1yhN75YLicy7Mqwrj
X-Received: by 2002:a17:90b:2584:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3b1b0ba61famr5629200a91.33.1794686761104;
        Sat, 14 Nov 2026 12:06:01 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm5258887a91.0.2026.11.14.12.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:06:00 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:57 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
In-Reply-To: <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Christian Brauner writes:
>+	/* Look through stacking filesystems at the inode with the data. */
>+	if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEUDO)
>+		return -EINVAL;

This looks good in general, but what the bots said about O_PATH files
here is real. With FMODE_PATH this is reached for a file that was never
opened, so on overlayfs nothing has been through ovl_open() to look up
the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
itself, and when that fails it hits the WARN(1) at its end and returns
the overlayfs dentry, so the check passes as well.

Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
it's easy to trigger with that. From a quick test with a metacopy file
whose redirect into a data-only layer points at nothing, registering an
O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives

     ovl_d_real(/f, 0): real dentry not found
     WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
     [...]
      file_check_backing+0x308/0x5e0
      fuse_backing_new+0x219/0x4a0
      fuse_backing_open+0xe8/0x390
      fuse_dev_ioctl+0x53a/0x7d0

and the ioctl still succeeds. A normal open of that file fails with
ENOENT, so nothing could have used it as a backing file anyway, but with
panic_on_warn this is now a panic.

Maybe ovl_d_real() should just stop warning when the lookup fails, now
that it has a caller that isn't trace_uprobe? The check would still pass
for an O_PATH file whose lowerdata couldn't be looked up at that point,
though.

Thanks!

Chris
