Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79849443C29
	for <linux-s390@vger.kernel.org>; Tue, 29 Sep 2026 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697565; cv=none; b=pZ7A0W1vGvCtb5ZSucyP7yCZ3FU7f73cz1TKsXPU4wgZEx3Q5Ya8QHyc3y2UfzPs/bTwbqPsSw+I1RJu5wQBiYCYvqieyVNclVg9/jv7GWe0Di3XPIq71OYY8LYMVtgGq/HN4Yann0s3SkJ8h4uhzeTVOsc/uPoncYBogMp7Uuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697565; c=relaxed/simple;
	bh=bwnWYK80nFfKr3iwUcfFe3FiEOIbobSQBQGXAMlfsws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRnHqVEQoh8zFipxVO1FvhSEcdn+eq/TqCA5dJhzJ8ZBOcmhtsKJMy7xMJhwYg7R7XykoirhuH8a1zOcAcGFX4u8/bkvr3YK55htaSUHndYEDdsH56YN1cWbfBpgFjQReVGmJ4RhoHKthyNCtRAx+pa70erCX9nYUOG9egR2UIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nYBYdIxr; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nYBYdIxr"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffe281cb1so20297105e9.1
        for <linux-s390@vger.kernel.org>; Tue, 29 Sep 2026 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790697560; x=1791302360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3j1GsvDFG4oGBkWvUsNYUZ4jWPGCGdM9fhJMq32ExyQ=;
        b=nYBYdIxrDawbXfSaFe7w3OFYOIJlQrI7qz59yDzNoP/mpoddTQw11jDpz8fIdtFR8U
         Znr8Mf9igyXtWKyhX9oMfdAJDqgBGoGjvHJ6igkkprc58F97zd5CcoCsAlzLvRI3ylim
         m1hLqtLjxW1ZBq19GMmUHaYSFSOffW8bLP3K3qMkDov5FsMy3S3x/irgsjS1eOVIRxq+
         mTxoNRrvS3DP/l/GGQcl6eQRSamNLt1PpjT8Td4ULW0LxMOaLDCJ+NvWfW4h18DY5Ss0
         azhkGRaDxXPuY2FEehlaV3VB2aS/wbvlM5l1jOZ2enaChDZdM1x+J0h36wzrNkROlZrg
         6rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697560; x=1791302360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3j1GsvDFG4oGBkWvUsNYUZ4jWPGCGdM9fhJMq32ExyQ=;
        b=ziHz26KgzHR8xG4DRe7Qlx6GdkKJCHIQK/mIIbeWCflcjTZPoqFWdkfa/+8EFPjR3K
         NiOrsA5Qt9rmTwrhkhhz9zpIXVO7oTF8amrhpvZrU42blQTbWNYGWfMjfPTEOoFdff3Y
         N2wZTE1I5yic9iOzeqCzRzEUUg7moC1lrmiRY3vbraz4E18xTa6YyDha3QCSHYXaFMEc
         AUvKvFjk+svuOYrYsHvVh6Jiq02g5hMWy+K8518aC3JZlv2sm9THf9l0qOu2DuqMgecO
         KQx9+DEQng9A6c0e5DKogTyIFBqdZ6YnSk9M5PvTKrIIV09ol2n0imPP9D7eUwIYur3L
         bIaw==
X-Forwarded-Encrypted: i=1; AKwUvBxRWkURBvR1pTxmOtJOdq64XO/fDl3KMjrwZwjWwKg8LzfhLRdj5VhZD/uuNFp+NbyncZGYT6iJN5KL@vger.kernel.org
X-Gm-Message-State: AFuF++kyeKF7n/1BGHi/VGcD1E46ZhlW+k7V+J0M32kd1VT7alx7dcqX
	mUIxWuK4KvK/Qi/CUMkuv5iC/lPm+REAWzknKC+T0OmA27OX2ZuY/EPp9Z9Uv0uOktc=
X-Gm-Gg: AYBFou0KbCBrW2gnQA6SUYADpLL18ScOABpgcmOfLsevPC5bbjfBwhWGbuDo42wLTbu
	LMAABXh8tX64bmmVS/ZbuH+M8+z9GfuHtk5dkpx+XQ0rppzOcWs4JzrGpFyhAZQ2Rw292hILgIs
	Os01lDUXYjvljE/P02qpgweMyKj+NE0Bd1XRXEGi7CAZGctWsAfUFv1ZudTcFYT8zzNr59NWSOC
	Dlza8oKz2PMuSN5oKzkFE1v0BcvzuoY1RTdOP8IOQPYy+XqfGDQVKquPoQ/msjGGOpMtWMBAEMU
	D9KwQgLQuqu3mZ7LgjGPsza45N/yHURHnoa7FSjoZyPoAzBfNoGA4+MOLKxOqBYzgY/cdB6bVqL
	7DwIwEuvSOB9H8sjieWJmqk7nTY3i9QHQUoFLUeUKeZ1dU3X1A/NJtSjWeHBxYSJLMV94k9PMok
	Aly8KXYpUjSRzRINASEipSgG1p4RbxycaVH79DIE/h6tv20JxqJS/g4K3AF+MzTjG39A==
X-Received: by 2002:a05:600c:46d4:b0:49f:ec98:f030 with SMTP id 5b1f17b1804b1-49ff06f839dmr227620145e9.33.1790697559827;
        Tue, 29 Sep 2026 08:59:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::5:5c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013c6f295sm7062155e9.0.2026.09.29.08.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:59:19 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:59:17 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 07/40] mm/vma: tidy up map kernel pages enum values
Message-ID: <arvgNTUgcO0nPh-V@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:16PM +0100, Lorenzo Stoakes (ARM) wrote:
> MMAP_MAP_KERNEL_PAGES is a mouthful, discard the MAP_ as that's implied by
> MMAP.
> 
> Also while we're here delete useless comments for mmap actions whose names
> clearly indicate what they are for.
> 
> Also update the userland VMA tests to reflect this change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
