Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242BB47ECDC
	for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686488; cv=none; b=mn70XQ00hwBX6JEArUekRFHP0vQ39H8u6aFyC4+nRwT9KNs2BEJFnZXhROJBurEAIFTP+5B9VQtClul/apCLdLE4eovG6mjqKrdGUMbSwxrpudB7LsvGwmsrbxT+hJhcBmCtI5uhqMf/fHkrrs+la/NWCJGJDvh/XhCcjGZV+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686488; c=relaxed/simple;
	bh=juof8ClPWBcdbohM1aei0MyS3Zb/FxQ4cYPoANkh300=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLZHhRnztV3Ihg0LYEKJrUAjnscCYkBoF4g5F2eaXleIiGLLMRmSmWJd9yaWlTAJ9K010Sa3ZiugS5XMw/Tl6MBrA/bRXWnNtKkGgvcCtq8iui3vVR5CxYJLUsARkJ6tFX/0EZmkVYgJ0+ys6vMvcoFopnm0zd7IxsoNd0zVjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imrjxX0c; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imrjxX0c"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2bc7b311e77so18586875ad.0
        for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686484; x=1779291284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sULJalq8qpR0SDmRCBfWcTtKyEat46ygMheSeQ0h0XQ=;
        b=imrjxX0cTYlanQZ7gYA+Az1GipburGcWY5CXtIP1+67BLO5IjcuAa1fpin18csCpjJ
         qtAyaEdDRyXPHx/RA1dzqn6vMBYIszLUSqADA1w6Sw9cxYWX/O0r2EImBOvOGXMisUWc
         qCYzR4Zl3IOojPVGPvUEURhZV9DkDmno5YyicrfDs3e8nmSo01vEnbd0UT7WKEzdukk/
         KWxZvMx2YIxKk478kCwXztvMHoUO+JlxcvBo8g+BvbPD+qcTa99C4CdHWeuHrirwWbsX
         eT0USPt04nZ6be1jKwRqUyWSW/HbPsYxw3vowi0IS6Xj8yIvZsnaft2PET1bWwIxkpLf
         sJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686484; x=1779291284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sULJalq8qpR0SDmRCBfWcTtKyEat46ygMheSeQ0h0XQ=;
        b=ssm8s3N9vqATHKfLgcLiuoQPodkZXYr12F4na/aypD3LHPiL0PZdGUEVMiC9o+KVgX
         U2gk/YuEfaFEkK1SGAmknjlkSWvPXw1u3Pj/Qk8iawJxjynhBkp8ePKxhx3WnHoIcNIs
         Q1BhXmrMXI+abEwkGAB16NNqPGS/5GG1s575Q/T3gtixgfCXPT44riX/3/uAiRrdjrVu
         SKt7HpLpAH+hGdfkfTY+BFTmikK32xX1Rr2PhLjndBrzU4QpURqEN8S47xDTqXX8dSyL
         HbAiC+xbx5uLJoQ8Dr/CW0ciwRBBbC5N8vpzDKLT+btVZ90QSFLykkUniV24S+eNbxGR
         pZKw==
X-Forwarded-Encrypted: i=1; AFNElJ/Qzk9k8XgRQisLkrBDnDv+xRaD4GfLspx3e6KJroYPJP5YoOV9mWo+nxA2DodMQPzTgtkkzVSohhNC@vger.kernel.org
X-Gm-Message-State: AOJu0YwDx/ekt9QJETR+2XUplSg30mMHfv7xI0jJhTyEaZChXZv6bgqX
	CICabJU7Q/87f19fI8LgzgWetrkD6iDz1G0GElp/506fO/HeCh9MBU+s
X-Gm-Gg: Acq92OHLDLREPLEXQiy/1fC5WykFlzGZzGjpemwcFjQ1cnSv3LgxX5C0/fgsMzSI9px
	bBhCGFQAt0RXSDHabe8O3iAoSVkaEa+fj8Sj4xS6Rzy/e+udD528vLWB9ELPKQdnVhBYOFBZclv
	aSDYo9B13HJNYYDh7dKPlU4aNPOEyCIMvvpWj/9mVLsw9N2CA8SQWmjgjCVQat/Um3LoSrlamva
	3cjogzPGcxpcIoGPhHdPwqN7HZ1lK1IGwJzjUaBG79STn7X9VbHu1Rnuz10QOHPo/YUiH3yl2Eb
	mtmsuij6PvboLZ5NN/lTshgXGqAAhnGPqqGJHONoyxNFUVprIcLLKDfpaG71YAHzwumL5n5ex61
	utUKMPBbwDZ31v6Uz5CesBnHlOoqmjWNsXjLbJfMmzRk+4UU152Qf1SsAbT0Yvxe31B1E/KPdtu
	ux8N6NwONlubV/Y6+3
X-Received: by 2002:a17:903:1aef:b0:2b9:cabe:ce37 with SMTP id d9443c01a7336-2bd526ce2dfmr298035ad.1.1778686484215;
        Wed, 13 May 2026 08:34:44 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ebea72sm174932375ad.77.2026.05.13.08.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:34:43 -0700 (PDT)
Date: Wed, 13 May 2026 08:34:43 -0700
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
Subject: Re: [PATCH net-next 6/6] tipc: convert to getsockopt_iter
Message-ID: <agSaDOAx1HBSDoCQ@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-6-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-6-fe7f0e756fac@debian.org>

On 05/13, Breno Leitao wrote:
> Convert TIPC sockets (msg, packet, stream proto_ops) to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *sopt
> - Use sopt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> The sockopt_t parameter is named sopt to avoid collision with the
> existing optname parameter named opt.
> 
> Note: Dropped the unnecessary parentheses to make checkpatch happier.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
