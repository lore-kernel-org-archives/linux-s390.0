Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7A30675A
	for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686400; cv=none; b=tBInb+VPcF8n8m8yS/u3tSI1iKfyD0Uuh321iY3Xji+POBL/kekMw+aXlU/o/Owb+y8ObQYG82VSxEQzXWeSEALySn6L3vKDMBkNGTvuJQsmkvfB/nr7ZJSP1N4igFIaK4VWZbM3zpU3ltNcNo2D7WTeBENEOlX0KznbgzNJByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686400; c=relaxed/simple;
	bh=ptCC6ECWoq8NwvEdGxDOHxyoOAmU11HMhIDNaeufYn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmd+bUiWXVp0g/IuglfNzept+r5c1v161wqlQz0373/7SO1wQEEYy/P4JY7lc8gdlaffHZo9Jl2oxTsdCZnI4TpOoSPbwjWQUUoLC7eM36q4azM8ln2f0Otr9NzoB6SR89OJ0yVRrbyNKkQMOwmH/thO/5BMMxv2Xrw6h32dqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE9QBlWp; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE9QBlWp"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c801912c903so3267455a12.0
        for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686395; x=1779291195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9pfvZX6NILfeGSOJxHfBjON7lRfDPEPyL1FGEyg6nE=;
        b=iE9QBlWp5OQLkejtWY/11Lz8YrrdM/OYTTKVvnKseUkr/lI6vH/bgkErOF6Hq1KZFP
         lDcmgu9s93arsru9+rFQbIulGzqd335bcMAIUoy76udbWQaCSrtd4RDfhb1hZIXJFFut
         UwyOxdJE3i8oG4GMMGqnuFqmMLSycCkuub2/zfTAzWuaQ0/nuGHxlI1s1nYMdaCIcR2p
         xWydnJJmVWwEzDJRtfmh8MUAvYyU5vSAle3sraXh9xxxRvxj3Z0we77JR1hdjmZfv6do
         BOlaxxvVrvcM5wQPC0VN1fcORyTAK7p/A4ejyWQJrpD8tfhO08w5cQJhPdjf0NQRJ+1y
         dWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686395; x=1779291195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9pfvZX6NILfeGSOJxHfBjON7lRfDPEPyL1FGEyg6nE=;
        b=oJv9Z9lkpL9gTrN9ztXOZgyrePe4/Z42+1Hoj4TLpV1E2I3jP0Vh2D5OJRVX347FFe
         cmbqqBeFWvAV0ExBciSVcZY5Shc/HdqVWixc3yMtGSMrqsjAwUqPRfpbYBACOAFvc9AL
         7nVMZDpU0KicZ1M9KJZSUmF8MIK9g2jrRr4lYVuBEgyiTbBqDSnuW43CtvBIOxKkyJNL
         pBDPcHiJAvBaZtnhM5yPilGZaaPXhdcWwDYerXT1kJ2YU6J7iMrmN6WC8mI+5Ev6F1bt
         9iA+K/lc7d7RLHQ+BkK2O2OxxITFBaWxDB2lNbUfb62q7e/HVf8CFW6Mpo1rqxS5kCIA
         WWsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/W8nRfEcn48eDAJnEMM416F6HL47Cq+4U/WqLVEiUyTBBZvhUakA+0q7hVftK7a7czs5x/LZTcVhRj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4CYEAw5qYejsQIqkYMP0xJBW9e2v2enRGhf6FmJDnDyD75TDB
	3ycX3rbhS0pXBk0160/loihgd0x1Xj2f4k0fYcNYHPMQ2PtWggw45Yd0
X-Gm-Gg: Acq92OH1932AT69ObcMftPI2K0d+qWn7X3DKP4UlJH0IlyHKK062eiso3+0CIEEkCO0
	O5yYG/KCnjG1VC/YitsVlzF5kgVd+jFOV5xWOVkpXK9QlqZlKBzShWDSrkdTZ1uq0xNMh+VMIb6
	bLoFOMNwACzCOq8vF8hwwywVubkWRW4xV6sTUcPtWJlXDulTKL1mkF7wJ7qgOLCo5TYgUKQkRjy
	1s/uKpk7be5XWLs5hvpq/AES+L/65/RVgJSSD48bM5pRU3FmstQAu8q46Utua0qaI0YVeNKZH6L
	EPfbdTWUMvr41+/dSisbbrMiWFTJsFLa3sPQ1HoM0HQG20eRrtEex1iwLhRHawigqS37WrwS2e0
	BdNZMDt35tCM/asDviUjfvp5Y/TK1UCdQXqIeJAtGRjAL2rQKUvNIiodF/7bctABJuwu5RQ5IkM
	07jaC2Jzt00OPWsjQE
X-Received: by 2002:a05:6a21:6d8f:b0:398:6bb5:54c4 with SMTP id adf61e73a8af0-3af7ee34f61mr4503273637.5.1778686394884;
        Wed, 13 May 2026 08:33:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:55::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82675fb236sm15718164a12.0.2026.05.13.08.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:33:14 -0700 (PDT)
Date: Wed, 13 May 2026 08:33:13 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Chas Williams <3chas3@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, David Heidelberg <david+nfc@ixit.cz>, 
	Samuel Ortiz <sameo@linux.intel.com>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 5/6] rxrpc: convert to getsockopt_iter
Message-ID: <agSZsZGe_MpQzY0L@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-5-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-5-fe7f0e756fac@debian.org>

On 05/13, Breno Leitao wrote:
> Convert RxRPC socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
