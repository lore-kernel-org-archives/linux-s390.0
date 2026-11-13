Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606154;
	b=uSBOvr5YwUIWOB9DrecClb1U4ooQAA7J4MA3z0IDmupWAIeATZPAZBuIwAALNn0NoGLv
	 qd8UoXq3KxvN1r3Axr9c6hFpjQywbUJyirwOVaU2GaXqwasObLg/qMF/otbyNz98/mtOT
	 GSsNxgYsXvetJtVwpGXXzB6QKh9lMvWy/RRJtvmAb+u5HCYv7IFAzAC1SSg4TYKB5LsHY
	 mJc54JVZQwKHLkko4EN5KsyTjMiw4C6Q3PufAzAo4U36BYGXUZrCaA73b5elLTEUbENRB
	 3J1Cv5ABplpHgAFVe6Hg0dzyUCKGlTivFx28iRJFDKo9kdLUDuVktjHFrRPL05KhRNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=RwPRyHP2zyVmejGR1uh4JtlvqhjIfEODs3w+QBRfcJQ=;
	b=gwogXx2kKECusKaUQC3gEU9PJ8R4Sg65zADiCAyskvofm9vM2wbY9wBuI6AmnHFo5BX3
	 rChEZ57ydoFJ/PMBw3xi+632uod69oDxQ3etqDPpMhkok0S1ndgXIwtNGmAaseRYos5fj
	 myJWMNOYiTGQe1DzvYcuGUGo2ENsG4HFcdDvbc7RqYe7qptOrH5EgijOEni/7TqapQb7l
	 id58ZR4OvwzMkcXv4MEynGkK6dyk0OuY5ZtV6wzyinm6z288V1TOOvO7XSZj1FIihz3MF
	 YSvSGxXa0rRBoKVazyotU9/CySnFYeUP2fC806YIC1alnrSdhGpKbjYtBmzkq4Dg+Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EKNhbxkk;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE5606A33A
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 21:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23BE5606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EKNhbxkk
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533861a59b8so27900981cf.1
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 13:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794606152; x=1795210952; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RwPRyHP2zyVmejGR1uh4JtlvqhjIfEODs3w+QBRfcJQ=;
        b=EKNhbxkkQMORETffHCHxv+E20muavs46wHH6TSQgkwOKnkMBWgo3BRqE9adDNYWjJy
         zQvDt0u803Js/yQ/xoqMXeSOKFrPFOOfSJoo4mM3wToNSHCQYLMW01UMv2NrALxHTu5h
         1BKsWm9UIk97Oq6GlYqwEE9cIn2GNrup/GEMawiM0oNLiEcTbAAlcoNRt+Y3u+jnhl7q
         Ff+CjlTIZlIH6YG34N3i7rGeKp+IjYW/FeYl20DzdxfeXsbexBmN7BiSt5uKr6EoNKuM
         /dW15GIGFRQ4M8aVHf6ioFgdIR2GphR1luRLbU/sLdpNwfOidADbdAlqrJzVjjLlQ4ap
         SzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606152; x=1795210952;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RwPRyHP2zyVmejGR1uh4JtlvqhjIfEODs3w+QBRfcJQ=;
        b=s044FSWlTHRUBh99W8skcyVGK0GnDJDfO1+BWT6plFL3skdirmUca6IQglCYhQRX8y
         9TB6/+Okp4h6AgJEMM4kO5/ps3q1+O4y12CDA0iaHMUzSoqoOmbRjTkkzwsMsDFFvc/R
         I6+nAcOh0pjPu3HlD386HdL1azjEsqaftx3B2mSdFRGDeloLNXxxRfZ/00BtdyGibFba
         4TWBDEb3/45uUQ4T2zoMqewgHqzks58C0RKDNTJln1VNY0X7JVHQZKO0xuu4yZ/uMAur
         yU8eyGzdu2mMNXxxldFDM/oM4Xa0C+SuubD4TAxfJ509Gwdio9YlEpt/wAzv4Mufow74
         3Ecw==
X-Forwarded-Encrypted: i=1; AL+hErHZPRDIgH/etwfvxg1YHHV62cQHYc8aJyrE+LNK0om6Nq3JqLuz+F5sZKvEgcLbktYHs8I39apxwNG8@vger.kernel.org
X-Gm-Message-State: APuU4Z8wPYvx4eYWJ34zaDl6eGY6B5hPtahC8DZClDfIXazQFgQwn1uQ
	id/Bym+wONr11n1ny1OB1zESxYOANEcqvA8IiClz//RuGaijb9Je5jYGSHPa/0xwQaU=
X-Gm-Gg: AYBFou3ccEHsygVlSImieUj45NAA7ZkL1gP9beW3oZHGz3CUaIPqwyk57oVsy7RaQ8R
	pCwKmc6odzZzsMm24VmbuFxliguS+u7Gwy4mWTSWhvlmdJ8N7PWUyjJmp1/6CA+MfiKBu+1uo+Q
	CgALz2mecOupWjuFtc4mJl7umaztcE36IDULusRrIZ9wP9miH0UUbEzpy2IprvSCBJGXnoXfQoS
	dBahfuu5nGuChvA0xGhOEUfxpgGAyfCYaP3pLJWhrPR5DSbUWwfzKQZKGD1UgqTjBnl3mb4IT7N
	B2DnQJORCIpbyy3iu59iYAR+n766udhgwhq7ZRIHcA6RclSbFd3lPsFZ0LLEiw5yJ/OXWZgPS09
	UfCqWIhe9Lb5x/5F7m459ZC1W8ZEQSWxx2Uy8JhH5Wmub5ISw0NFP08KKvxHgohyj58vudPAuJu
	RO53+TGW5KuVPoi/27pGFWR1bSbiHNAGxIioW6ewGtIx/lEeSv0hnXFzJ2Wb2MMyuH6PQ4wrQyM
	j84eReXnrXQrMq3kHLvGtNdubh3QZgyBZtuqqVqV8CSx3dXC9I3NdkYjb13C+fFgax1OEKEYz1W
	VOhUdbUmOW8RbiJKU5wdWL8qBygt8G0S7MBkxojrD6O1U0xr1RP0ZXfz86lbmztBVrHt+A/bRWD
	z7yP0RNU=
X-Received: by 2002:a05:622a:598e:b0:536:566e:6b52 with SMTP id d75a77b69052e-55ac7564a85mr62222541cf.27.1794606152109;
        Fri, 13 Nov 2026 13:42:32 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0349423sm27363181cf.7.2026.11.13.13.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:42:31 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/15] hugetlbfs: fix integer overflow in fallocate()
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
 Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dave Airlie <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>, 
 Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
 luojiajun <luojiajun3@huawei.com>, Josef Bacik <josef@toxicpanda.com>, 
 stable@kernel.org
In-Reply-To: <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>
Date: Fri, 13 Nov 2026 16:42:30 -0500
Message-Id: <179460615000.482102.14809359037930927808.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-28 21:13 +0100, David Hildenbrand (Arm) wrote:
> hugetlbfs_fallocate() rounds the range end up by adding hpage_size - 1
> to offset + len. vfs_fallocate()'s existing overflow check only makes
> sure that offset + len does not overflow.
> 
> Once we overflow for valid endpoints near LLONG_MAX, we can get a
> negative temporary result that is then converted to a very large
> huge page index.
> 
> A one-byte allocation ending at LLONG_MAX can therefore consume all
> available huge pages. Pages added beyond LLONG_MAX are skipped during
> inode eviction, leaking them and triggering the BUG_ON() in clear_inode().
> 
> To fix it, calculate the end index in a simpler way that cannot
> overflow. This also fixes the signed overflow reported by luojiajun in
> 2019.
> 
> Backporting notes: without commit a08c7193e4f18 ("mm/filemap: remove
> hugetlb special casing in filemap.c"), remove_inode_hugepages() must
> include the final huge page during truncate and eviction.
> 
> Reported-by: luojiajun <luojiajun3@huawei.com>
> Closes: https://lore.kernel.org/all/1554775226-67213-1-git-send-email-luojiajun3@huawei.com/
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: 70c3547e36f5 ("hugetlbfs: add hugetlbfs_fallocate()")
> Cc: stable@kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reproduced the BUG_ON() and validated the fix.  LGTM

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

