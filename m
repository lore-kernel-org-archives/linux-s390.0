Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794657339;
	b=Tv1ywJIPEIHYksMVdYtQv8FGvSs6AZVlxnvaOXQGEm1TO+8klg93Xz47JN9G+vdK/FPM
	 ImF3VLPZ0MCA5Bg42OJP6ncYTy/8LF0obgbH/xdBEIUNQeEHgXuApElXod6YwowEZmrEu
	 ohQCbax1UUz7dNLB31ON+0TYnAwzeg/YAd7kon5SIQ/MG5TxEHkfpyOnBxcMHg6bXCzHv
	 LmWr6A5PgXCkdOlWgTa9n3wtXn/GYkhQ8BSHKspiAg9+yGp0CkU5vqjEXoI+GpOovHFYb
	 sTklgA+8FbFmi5xAykjNJ0rTJV39FiUMTJdfEcEeAhzS7zGUng0GZLNLgaPaLsDtSpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
	b=volJ/MUG5H8pcvIUGUjW6iJhy59M0vu5F6kzt8Qi4dyQdXvWcV159bWh4AecwfTCNYmF
	 +aucXzs4ttTEfQ5rxaaNDwz8Ou/yc4rco9efjxx5FvnWFKzCOIJn5PMGfvbQPHkT4O5mu
	 +TbMioXi6Lyv1KomApomafkO46XHpzDCx6zHuRZrgt5WPuw8JETTGOiqxP+aVi3nqD1NJ
	 6NSh/qoM4RNb93AvWV2qj/YjJraSDQkbVlRRGlfbcCo9sSlwCkh9iHG6JYyNO1CF2uoFq
	 w/q1TfRHH765v1f1wG+2GksFBeHaY/Y8gOvb1D1g9imTcB3YCPGbZ3065a0FqR5v3+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrTBjpIE;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78196606A33D
	for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 11:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78196606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrTBjpIE
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so338682066b.2
        for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794657337; x=1795262137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=MrTBjpIEXzsSZaANjc7oExJhwGnF+j3pBQoJGLV3AozjECewWnT/dOn8PoCfUIeYGI
         mRgldWBhVoyoY4kjpOu/TkcCPMpetn8bMN74Irqnk0JnK5MAQS777TE3iVfENO0qNvUE
         8qb82pxhdLikkA/6tATGUpByZMee1vHTbdl6A6vtosorr3+hE9wD/mpuH76lS1WAZqyn
         nUdTyabyG8UAyWqGnpYJGfY62DgpvBldD5kNADP5MARyaYxmHHJYDsQkr6qVKrnaldzF
         KHIyaxdpU8Pcl80WjVwUUXXw+yU81KD0D8RdN7wE6Dhf//BzElFXAKq/AgQBu3vGzFII
         7JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794657337; x=1795262137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=ml4I23ScKn2+08nVRHiVdLcDza7mbTUlQnQpMrFiKrTi1P9IN8TArgwPeVXFptvYEf
         crxCCDuI2oeJlk1cfeyzWt6S/xuFvuoiRN6Q1kGMWUBYjiarx/1FgLsWG7mXgvSXBPnj
         rfynRZ5Yes5b+T7S/QmVG6H8R2lvSrSNGHqW90gme4YKUV9EvDhbdvfYs8ZGDgwv73G0
         h4PDSpCroO6ElKxim7+XN+InbvrVF56BiABRAua8PFHssJpzBrKYpudsglzodgCKDhcJ
         xU34GmotHJMHGs2GMgQm54fNqKPbqxNzKDIor2FT3Owl0vy/EeVruIM8Wu7x/5gZjFZ+
         PbCQ==
X-Forwarded-Encrypted: i=1; AL+hErE/qBh9SsM/+yhuo8W6OyEvD6P17ZbPiMng8y6KSGtHpPMQkK9oRj6jBeU8GwLkvGxzsOtkUxR5Zmqg@vger.kernel.org
X-Gm-Message-State: APuU4Z83mVr/HMMCQwgR7mmLZCvzP6MSA4XoPjlBilSwQso3j2IM1Zsa
	EDgev05sCE8JlCttJOjVcJvxLe0KagNbExAqJASrjwqwsE7feihtATYD
X-Gm-Gg: AYBFou3Q1hZJGF1UcNSHfesAstQBzdhMjusDuWQloQrYqHsiHwyB7AbTzEWRRtGciJG
	bBqn9gWLOp/3n3uURD8qHBn5KgBBY6dTAtgY68LJBDTdQ15Kla3S6j7UNUMtZmryZROt2ARpQ8q
	tyTt0RAhSN8L0l2zc398wWFYVUnCzvpTOoyW8pOqjJOi/RZBjiAZ9G+PqFgjRtLz6CLulq8HGYD
	b7dqHrHO7wFbKpwIqXtDCKWhCEnBxrSKOIAga2i9pIyyPaRmZL+3KOL4en8clenBCnbuod2n54E
	xdmPY3i60TabC9jiZwQbxhEawFpwmajFT09f/zFu9bgDMFKG8aabDvytTXYELgq/sjYZX63Ero7
	6Phfr4NdZoZa1awNKyx/ol+JyEQ2sYo5vDrpzqDn+wJhLO/6KqhgB01kITNZ3TpXyvCvMQSMDAj
	a3AxEGiqSvHl90jDn/EeaTELsIjtL9xQPcEFqvS5uHv23jCv3MWPiGLHYEKGb4J2cJM5UEs+fIt
	IxDm37/sR/HZFMzyB7IrI9Jf5VcETL/c7dTOw2XcWnseXy2uiG1aALqFmTArtlXUZvXyrK/mCS5
	FwURh7rriAJ7yllZqg0Y9qtpDCseq5TxwOD9S/Y9R4SVpBNc02wD40MPONNKRBgem1qVdq8z3O1
	7TGPROJ5LxEM=
X-Received: by 2002:a17:907:3e10:b0:c40:231:6eab with SMTP id a640c23a62f3a-c5096370c31mr441592966b.16.1794657336589;
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b41f44sm206223866b.31.2026.11.14.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Date: Sat, 14 Nov 2026 12:55:35 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Alexander Mikhalitsyn <alex@amutable.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Message-ID: <avhMN39TECaur0sS@amir-ThinkPad-T480>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
 <20261111151202.GA11391@lst.de>
 <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>

On Fri, Nov 13, 2026 at 11:25:57AM +0100, Alexander Mikhalitsyn wrote:
> Hi Christoph,
> 
> On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> > I've seen setups where people use fuse to mediate access to sysfs
> > sysfs in odd ways.  No idea if that's still around, but if so, this
> > patch will break it.
> 
> 
> Oh, that's painful. Do they use backing files for that?
> It's a relatively new feature in FUSE...
> 

Very unlikely that they use FUSE passthrough and if they did
very unlikely that it would break their filesystem.

The API for fuse passthrough is that the server requests to setup a
backing file before open via ioctl and if ioctl fails (as this patch
does) then server falls back to non-passthrough open.

The ioctl can already fail for many reasons such as MAX_STACK_DEPTH on
procfs as the commit message says, so server needs to cope with the
fall back.

Thanks,
Amir.
