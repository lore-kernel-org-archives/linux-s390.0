Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686757;
	b=HbN+vWTM0FmTH0Ueb4feCLDGh/JLx6NvrSkR8EJw/YhpqT3HIsnG+rljeOmV5gxOBmdR
	 U5eChk5NGTxR1cZ2gVk1l4+jHFaV1PfVqO/T1x7q2+mLYFNQ8kEO3lfQ6QfCqcS3XtAOA
	 3Yjaz1XLDC6/J8mtAbIinmCEW9WdUUQDPT0NbZa9+8MMM8SqmdAZhez0aNIKChWqQFUNy
	 Liq59jC8MWfSVOfUxqNeleq4qKBUjEaI1CZjXHUrxiq97pJHRQIM1dUvG+1LqeANuipsY
	 6HdeMTenevSGq29Nf77FZv33p3+F002SNQE0ltxpp6bEr7n1tD+ePDPODJZLFVTdH8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
	b=bChirzrfanavFCUb4ymWWVAQ6VFAv5JAKDVmtGqwQO6WNL8LzDaXJUQFiZcA/Wn/SGY/
	 oDmiwWhGMOqppuJKVaZ9Ek7++AW36WeTQ0f4g8zDD5Z3D6aYUZ7txV+HVKTcTdXKaHigK
	 B9ZEdILvNfiaO3NTU4z7DLB/Xk9af3VmZjlIA/AB5yrVndyvWowW3tm1xjLYSwvgoNQYM
	 CFT9OoE7yhHLmEToEUQ0cg8/Dv3G20nlHYLK9JcJurjZPqFbeM8PvtPGBt7jdqRPb8oiM
	 +41I4HYMtoLIRq+rcfHJd1txQZn7TzAJ+gFifSxMyvERfYm0M3WapWyTgLvbiDc3LsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZNpsvJMi;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA25D606A33E
	for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 20:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA25D606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZNpsvJMi
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1295172b3a.0
        for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686756; x=1795291556; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=ZNpsvJMizOoFFuviUq3R3I7xBszXKHR6f+dU2Lhp8+AdJOsuucW/Jpjz4DKxOc01P8
         7Bf2gXYBYorSyL2ypHSps7l13uEx7uOW/BQ3oCjgyM7fn4nszFId/ZhifmOhhkUhMak/
         Krv6vg2ZKrT882kZ97nfZeCj+rR5WiJ1p/wW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686756; x=1795291556;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=N6Y8Nt2Q/asMG9Fwm+zPIR9L4q+NHtkYkDY4HvBPu90+jk8hyO4CxQl4Kvrrs8gkDY
         sk2gWYn9d2EQth/BRvKNCoayUqIwWL+0habr9hzJOjI8bASFVu5yyT7TtOymHsnLo2sl
         VgeJwk05864KqJRf75Vf32pnq6ReByh4wNJ8YbT9eC+Ynsc8tMbdbKQ2DIVkIhOA7LS9
         02qL+Rz0y841omy+o36yPX5dnsO3vhlIzMfycgSp6Lrfs0wzbz58e9FjLET1KGa0UiJt
         ZySie3jB3wXornPBckDibDq6tp65QCe21yBy9JGW46vOGhTzHEObj8tqnm/aNSQf5JOW
         5TbQ==
X-Forwarded-Encrypted: i=1; AL+hErFi5ArwV/Ks3bxmsnWs0wcy1RgHiNRnwKm+IoQ+KjhtcN5YUlWJZE0TEezLX/wepcbCdNslRjagXGET@vger.kernel.org
X-Gm-Message-State: APuU4Z/DGdm4ogY6ZP0Jt6t2faWfpp8zt6XpoEmtqn/4zAi4PLrh7VPt
	gfoezBqxsNn5RdGzNWtI0mNaTxWUNk7srNbm2KrXv7HREYoECjBwrKo/cNqyt9z0XRo=
X-Gm-Gg: AYBFou2m86GYW09ntya4rpqBdwP/OyznBbGMNqBfCMyrjZxnWYg5HP3Gf0H53jStreR
	jYl9vhlg1tRAyV9aCDYsKs6XTtcEdgBf/Ts1SftFwIMZuRVHgDsR8BDUel3L8aNHhNZjMzN7JG4
	RH3+ZbTtVlUlC+nl0BgiPdrdEKLuL+EKCNbTAVnWn0iXz7n7Ol5ByLIDUS9rn901akdSk3YTkKr
	NWSNANnU8+ycymWsMYQsosMobJI7Xo9Z6b2xICzujUTU8dKcGkWATIKVOX6mrqrjnBYDKRe8+Vf
	w8qcq/raRy1AZteFecV4mJEKEm//BldxyLSk527XFBR71UWKxRWEYMR5ty7jI0b9bsm3Qr0es+A
	y1+dyZXJLZSb1JJ43FKYpLJsfW+9ho8/USsPXxDWkOha1mtVW0NAKX0NBYHPH5ltTYqCQaah22a
	k1vWufyQKSoaCA0i0qWIxgnvXPcqN5QyHTUOdgeJlX7jkC9NevMvxIg51+sZd+Rq/+CdecbitKl
	3CZ+up6j2Blu3ZZrAZiKG+ncAG0OE2qdONUzCPxkAIW1JDH23xjtdILJC8/DyOBj9mc0CUarjIL
	4/vf3ul+dwTM/VQRc6EXOSTlGlY2zbC/s9C+Stk3ZmovV4+/yhZyhTkwB3291DpRfOB7IZ9/FMZ
	aqayRAKWEH3Qk8Etsrv/Ix/TEYzw2O6KqBEMv93Imk4P91MSzq1oul6W4005nZxH/VzTPoUYarw
	n1j+BDceuEduO5SSHxicieMtGDx9dv0JezP8BmvHUP+jjjkhaor4fNeG+b
X-Received: by 2002:a05:6a21:748b:b0:3e3:37ff:3795 with SMTP id adf61e73a8af0-3f7a4dbfbbfmr5517650637.7.1794686756009;
        Sat, 14 Nov 2026 12:05:56 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8172sm2271197b3a.13.2026.11.14.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:54 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:50 -0800
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
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org, Alexander Mikhalitsyn <alex@amutable.com>,
	Breno Leitao <leitao@debian.org>, Casey Schaufler <casey@schaufler-ca.com>,
	Chuck Lever <cel@kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v2 00/42] fs: don't use pseudo filesystem files as
	storage
In-Reply-To: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
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
Message-ID: <20261114120550.0c9e73aa12a3072c@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Patches 1-11, 13-16, 18-26, 28, 31, 32, 34-37 and 39-42 look good to me,
so for those please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>

I've also tested 5, 6, 34-37, 41 and 42. The selftests all pass with the
series applied, and a uid 0 without capabilities can no longer change
/sys/kernel/reboot/mode through a loop device. So for those, please also
feel free to add:

Tested-by: Chris Down <chris@chrisdown.name>

I've replied separately to 17 and 33.

Thanks!

Chris
