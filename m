Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795085600;
	b=tDR8iUqxJkh9xWY4+g0yNZfOtw3EDYcGxOzLl8NjLYirR80FT80Tk43Efo4NxCHHXLib
	 e+PryczVdzK6uE+jClgVFu8+/uCZ887b6oyDT/bbAj+tqYlHASvO+dyuvWFU5vSEngYm9
	 9t/2rqXEiIcYTxz2qPF5ohVXnpdW0krZtdFuWl98ua5tRBui9GucUYWzAn/iwoQVvy+6N
	 LWxQN7wtvZK1EyDbjuY4Gq0ykFwDFe9OXhyI5WbjFg2vGVB/K7HUNdRXO7it/EDJ7j9Qx
	 CEZP19VORAyopS0HPMbvFJCS+ZW89Ls7cr1PFnkXjIjYft/PXNwR1ZMDuLdRv+GoyUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hqE0DnzQVOaqly9+hSqhRUU82CqCbvfu1P534JABEUc=;
	b=npcjL03RT0KqwhNRKt+a6H5ihoO0SgwEnB1aSX5tG31mNAxwAb8yt/3xl8tASuTxDCEm
	 cWLhwEyAL/qZx/1Iczh+mM0u34NvHWSHarho5v6f8LfDfi12bALRr4QxhRzB3zWrqhg7n
	 aOvYJEXn71Oq1BPBcwtR5g1KtTuuG0LoFL+FOf9wZy7YzVFL+gTHOqJqkBIS+5Ni5NjGU
	 VnZwoLABhH2JjNtNzkdHDfuVp4yYMgsDAFIMp3YiHTcvNxWBeBHOsX4GRh61U5Udh3lMh
	 OMFiRJCK/dE5vGs5sdp+tW1zfS3cvfSqmivTxQAqjwpG0/HPBXLJOjoTcvXv1xc4llA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bZwgAt4T;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17C7606A325
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 10:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B17C7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bZwgAt4T
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0bbdeae06so1193859a91.1
        for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 02:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1795085599; x=1795690399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hqE0DnzQVOaqly9+hSqhRUU82CqCbvfu1P534JABEUc=;
        b=bZwgAt4TKqTsP1xWCq97VLu+tnoq+LiOuNQD/HqwsLAazfa4JIr0ZvR8So4m6B/gc8
         pyCh66xfyXhzvlqFYjormqzWR+xuCQVe5MHETbIk2+IAknavrZFAb2HuDzIV9YY4uD5E
         eXCmuqHHuQpKGj2dAUDbsHhu4JTv3sobzZRQx7SvCJ6c78zIEKZqkmT8TurIob+jPDQO
         l+Y2Byvtvx3HnX8UX9g2bVr18Tf/VnViCYbE/yj4usckpA3RAVus5ErQNhSmiI0lTFzF
         M/tA9ZH8Y2QwAcbDD8ncuGc3O2eCmFLrk6xcrK7An2VBmdR9dQSCi0QC0DsILEWkhtUh
         cFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795085599; x=1795690399;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hqE0DnzQVOaqly9+hSqhRUU82CqCbvfu1P534JABEUc=;
        b=CIighpZeJXWxUpWw4eZGfG1PjOomAOieuHKG3QHfjWlMYnHWvL0OgDhGmuLNkpgyBU
         yZr8jGhNUtZ3zhXS0g4oFGUZy7Ieu5aPHh2pgd55qtO9aGgzl+EQHK0fMlF08OouQYwa
         f95FF+f1KfEymiQarpxw8sznBre59LLGHwuotQDhgIF4vyBl3uU8fR8Vu5rmEyIevqgr
         ZMU19CG700UVLUhQ+oNgErnIbYGKbrA2VWtwJ07QDQwxm4CFWvSufKn81RNP3bKtzho6
         FAIMMteWlOynlzd1979rUZAg6ChQCRz2msjjW0gkIJ92itM8vyYXzodpvX932rII7R1M
         nhkA==
X-Forwarded-Encrypted: i=1; AL+hErHmPXIlnqW5EyucC0iUbtlhMeEVWyLs7wyZ4TxKDzKCZjVwb6miy+OYkHqMdL/S8Z9rzbQdeoxH1S6X@vger.kernel.org
X-Gm-Message-State: APuU4Z+8yHysb5+6X/H08mmUmVQuEDpB1j2YQ00E98jRt0TiHfK6CkDp
	XCcFLYtXwvSV4wY32Rcn8VSHcPjB/uaEIkFyn5KxZ7/HAUs+Y8lOY4zDdJ04BltzsI0=
X-Gm-Gg: AZFdTZdrygGFuy1+XVUhpfj0tKoW4JMWlE9MVyIjAMlKx9tI6hAOQzmjPFWG65lKKb6
	6LtvezDcwvmp1PUSclKxAYhMWNpo+FXG6batzhcnd+E5onHBpWJGGNI4P+H3dmYOeEVsv0+Zili
	KEeRdKoD+a9MEcDz+vZ2hjq31ij+BOxAjelpcMb1Q5uiWuzFTrncMvm9Xl80yhGIGYWQDMFjznW
	av2hc57cD+Dos5D/uZfWjbem47KNPcdIcKiK0fMy4f+czDKmbOaz5xAl8gcwYLASrQr5BzS5R/1
	bwnkIhpMR3tEyOvkyin5UjEoNXbgkMBBFfv8Da7epbeWeN/mtTXJcgfowoyDHJQ65Jb0nWXJ08m
	kLPRAOXnk5aAHemdaLL1jlBkH2K7i0kuJ84weRb7qtftdoYK3zJrxxZWlp/rlM8aHwx7daQVYGM
	2PwGbIcI+0jo4kaXXTQQTOifu8UR3gSnpCdmmH0sANf1U9K9uIs66nj1ahrfPeUwtnFLfzBLzoZ
	5sKqIttkTgGV0ztzkHXqI7+/8L3uSmzWi3Fdzp/6yB3KoFcputD1RbSto6yGC1mONLwjs3qSNGO
	ViBw2Lx3uBbrAzVfkamO7+3XwzChdgz2I2OVr2Ts6GeYZfG6Y/qd5fCR/8Vkm/sZqiS4teeMms8
	N9HheddV4SdodcpO6VZBrpAvvsZSlzeFa4O4Ksg==
X-Received: by 2002:a17:90b:3d8f:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3b3d07c687emr4819843a91.40.1795085598784;
        Thu, 19 Nov 2026 02:53:18 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:e78e:f7f0:2120:34e7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm2246604a91.10.2026.11.19.02.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:53:18 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	mjambigi@linux.ibm.com
Cc: tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v7 3/3] net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry
Date: Thu, 19 Nov 2026 19:53:07 +0900
Message-ID: <20261119105308.2567241-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820023346.BF2B71F00A3A@smtp.kernel.org>
References: <20260819023306.644849-1-yhlee@isslab.korea.ac.kr> <20260819023306.644849-4-yhlee@isslab.korea.ac.kr> <20260820023346.BF2B71F00A3A@smtp.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The byte order point is right, and it is not something this series
changed.  num_rkeys in struct smc_llc_msg_add_link_v2_ext is a plain u16:
smc_llc_fill_ext_v2() stores lgr->conns_num into it and
smc_llc_save_add_link_rkeys() reads it back, both in host order, while
the rt[] entries next to it are __be32 and __be64.  Between a big-endian
and a little-endian host a count N below 256 arrives as N * 256, and
min_t(u8, ...) turns that into 0, so no rkeys are saved for the new link.

I have not sent a fix because the right one depends on what the SMC-Rv2
format defines.  If the field is big-endian on the wire, htons() and
ntohs() leave s390 as it is but change the bytes an x86 host sends, so a
patched x86 host and an unpatched one would stop agreeing.  Could one of
you confirm the wire format, and whether that compatibility cost is
acceptable?  I can send the patch for net-next once that is settled.

Best regards,
Yehyeong Lee
