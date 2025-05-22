Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F3D270EB5
	for <linux-s390@vger.kernel.org>; Thu, 22 May 2025 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952771; cv=none; b=BxlZkqcQQbA6ICwMIYc4rG6gULC29WUrUzbhq9nWcTk8jSCav7jNiFGiYLubr+nP39DYEXx9V3oJ7YPIrQrUSZEx/qiG8n2tpXj5Ly/aR/TtPD4nOKrBRDA2JCJC4eGTQao0SoA36Ym11fU1c/sYZ/5oJU5VGNt+xohdQpbPCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952771; c=relaxed/simple;
	bh=ERIIFgKxrnPwjSVA6jXYtUfeYroUqJBM9v+L48OiIjw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=SsNfVJvJKG6/EnyBB7OXfiLMdynXrM+4oFJCh1S5BClPTcoWc0s3Qd1Bc+PvRESyUQFpQB7+lxouXnAvnrD8+NrkvU0BNdWCMkDidCgJ8Yckym09VqXazLzNXxtEatzaGrTDN74c0DB1bAF/OjySnDbu2WOm7Xwi8fjmWJKe3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ToVMF8Pc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ToVMF8Pc"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c597760323so963196285a.3
        for <linux-s390@vger.kernel.org>; Thu, 22 May 2025 15:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747952768; x=1748557568; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yW4BwrWRPMGZw+m/ri6EFRKCjP4k+SeXSk6ZWrWvJiA=;
        b=ToVMF8PcVy37DRcyydOqAzRtU8MIfxnsQYcyTujtaPP+6rNuh10GiSxHl8BpEOL7Vl
         xP549yj/DsBJfMi3qCROE0CjVVteyRyHylhdLw04oGcxRiQntTqkGaj0qxDt91en7Yaf
         k+SmxoaFBB+G/5sErCk+bkQleUrTH6XQJe2p+LIipbvb4fbPmu1wnSD2q+VMoi0xxJsW
         gaMrvrcaiHSnHiky9rJUvXODz2114Xg3/bkQmKiZIEtphocJflv5aC1cQ1XzMR2q+5M1
         e5C3pB8Uc+2bJywG7HLAABdlrHUZ45rP3ykqZkmL5ezlodK/YayNjCLBFI5pn3kcMbPH
         Giow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747952768; x=1748557568;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yW4BwrWRPMGZw+m/ri6EFRKCjP4k+SeXSk6ZWrWvJiA=;
        b=qNs5UYZJvEYH1ptpPESzaDJk3ijb3/Xp8908c4xlUV1JuJUHYR+t4KcIYSxcaBjqXl
         URhjwypOxdNpiGsMfvYIM79DjsGCRZ6PRmY9XQwm4ai7Hh+4dM1FZE1Yo+WXZ1mMeICA
         s+m+1zJPeX5W4K1ddbIoTaaq8qVVUKr3HNScinMaur0+UKd49AuGeu5IFgUliuNLzL5D
         5ZVIKBCmM3qdqWoepb9V1QgIxjK6dE2s9ws/GQouxv34W90DdxFla3PNVlqTvWPbbt1/
         iW1FRV5p3ZWwxYYcrIOnKJDH1oa5ByuQHJT9oPBgjPphsO8avLnmSXI3GV0TstSj0m29
         raTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvAyIccnXvbTeyQulQELdztjWeQzhhKpg53qQGVYKQPln9m9fCVrqdKJPK9FwmIfYkQN82h23RO+7O@vger.kernel.org
X-Gm-Message-State: AOJu0YwYjKIauJ6Sx3cql5nWGIDF/TvuYbRPOdwcTglGJL1gfPYyC7q2
	PNgLpL3j5OY4pEhzzs6Xizsc5dGatsXZKuf+3VFk/jT9eS4Lg49svJXKq3DmhRdCnQ==
X-Gm-Gg: ASbGncuo/U5bXviseUow7VjLlO03KSj8AzP1ZK4Yq7t3TBqzlYjeQlu/dI9dBcx+LOc
	tRd8eCHWsV5XqxTbx5M8XDcZXNv8F4Bvq0mBMUpkU0uGyj5XoyFPLZYK5Cz492EcZjF/0T1B7pq
	oXEFBOHdw2AfMtUARlC+K9lyB0xELJGxAO18T66o2TQhr+v73ODnYbIFVqH1cHq3W+IwqjiwSJZ
	4x5WmIJiAo9r4ptFcLPlUrM48De0MjV5Uosex8QKrRMlaMxvVWvKuutYlhev/y8mydfepKfnQfU
	g1oGhzyrNdO53215gXsjWY+OJIylw1/WSwqf6hoBrnaGX8pbSvhMmOkz5l/BPi74ZshgH/Xd3sC
	TCPc4bflMuh78Sc1Wk9Bu
X-Google-Smtp-Source: AGHT+IHmIlyqjG6e3vdHM+wi0UqPbDaDdVTY/IdBlClNAbyXhci/B2Ul0PB2ozu0sL7+1EWeTaPM2w==
X-Received: by 2002:a05:620a:408e:b0:7ce:d352:668f with SMTP id af79cd13be357-7ced352670emr1334278485a.47.1747952768087;
        Thu, 22 May 2025 15:26:08 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd468b69dfsm1089029585a.79.2025.05.22.15.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 15:26:07 -0700 (PDT)
Date: Thu, 22 May 2025 18:26:07 -0400
Message-ID: <8bf36078ef8f3e884a1d3d8415834680@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250522_1740/pstg-lib:20250522_1730/pstg-pwork:20250522_1740
From: Paul Moore <paul@paul-moore.com>
To: Andrey Albershteyn <aalbersh@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, selinux@vger.kernel.org, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v5 3/7] selinux: implement inode_file_[g|s]etattr hooks
References: <20250513-xattrat-syscall-v5-3-22bb9c6c767f@kernel.org>
In-Reply-To: <20250513-xattrat-syscall-v5-3-22bb9c6c767f@kernel.org>

On May 13, 2025 Andrey Albershteyn <aalbersh@redhat.com> wrote:
> 
> These hooks are called on inode extended attribute retrieval/change.
> 
> Cc: selinux@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  security/selinux/hooks.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
