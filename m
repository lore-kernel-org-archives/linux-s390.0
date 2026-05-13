Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7015D38CFE1
	for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686173; cv=none; b=RlPSmSRrSCRbfiUfKnDXl5O29z4w329ISmVLHZIlE4pYStiUM+6nCmFtqf9FLQLykw9pQ/DtxvxiHOzJTwbk8fpEyZqccvKsdlCxBPrW7zXS3kLK/gj/inbY6zB2BIvU2OxZV5De14dqHhcKyxk+xI3aVUDewc9cF8sYFIpwKKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686173; c=relaxed/simple;
	bh=M1hEq7CvxLU6On8D8G12Fmu9StcYyNPtR454jTWVVws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJr1uFTe8nI0EbBUsDsMT8QlBpdKv73VvEZ6xSDJjN+G1v7NaTzAQTq4o0XlxgRxG1+No4YApM7uJqOpKRxFNtfC9tsXw02iOCF+qUWf2vEMdQNmx2EQyyF8WIrKSMVkMP9aDxXIFs7J+9dUlukiThrFfmQx9S3PWbUac+wd1Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTmdj9gS; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTmdj9gS"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2b941cd869cso44162425ad.1
        for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 08:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686171; x=1779290971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVg3X9kh4YDCRW/k5ke7n61nVYb/5/0InQTRe/5tw20=;
        b=ZTmdj9gSsZaBZY1YOfdpt3eODsKmrC/NOTOs4vTqCrI88TrchikfNBMBVmbvrVBbGR
         8ciyNnPtXhvLPGTBKAi3h3teHwEpEIhzP2ttmfos6w5J634Bc3isf5wpiDNJ/KdeZEYu
         GWsABXBgJUYsd+tE2ivAi2X2pcm166Ektny0jnkPFm38aoio0lg33Z/NdH/WfeJewPNd
         /2bN5ZpTIjD9TpyBEWGGBdC/Zz8niaYdjofJ7Rwrnsb7ZIJjSCaGeEXWQ/fdiioDmfSh
         dmDqV3sHmovTENOWdJELbrgdYij1bsA1beHf5HsxxVGzfQuOktdYLYcnWFJLtFnCn+Z/
         iPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686171; x=1779290971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVg3X9kh4YDCRW/k5ke7n61nVYb/5/0InQTRe/5tw20=;
        b=AmB9cSFB15TNaKd6DQ2K3+5d3W+n0wCFi0fVr3K3VAGWVJaGesD9HsGnESX8rnkzn8
         METsYRxNg0A+gafPfoBf75+I0KDIOERoT2vFmcIyQgy1JG5yQmxOJ6ABMFYqEhT9Z3BS
         sQHpVxFsZdKIpaeMEYOmLRYLLPpj95HmXtL2fq4vnJPPfGopVUEhwxYPR5z00oZvfpfP
         gGKnSj2fmSYcqU2R8NLsK55+d4OCa/QqA0FYbt8Tha7YS+e8zyPGMydYMkzb8vQjttCy
         TO+MpdC2hShjw9qs2pHgn+qGRj5Wj6V95BYg9ChQVEkmWCU+VLu3f8dYfvEsyhADJOqs
         UekA==
X-Forwarded-Encrypted: i=1; AFNElJ/szPHLnfvQY7VVzCbjAfrZq4oIzDqVq53ENfmdiecN9nqnRsUynm9NEBge7NM4NUaYFET73eZCg/Dm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fL3PEj5UzWk+IP7cUdbXAfJZ3fbpTaRQWxMEaEczRg/aVXSQ
	6tsFpHkoLAkF5+h9rXT63sGTgOCgWkvjATREAknlqPKCF3k1W0mGWKec0lj0iKuR
X-Gm-Gg: Acq92OGjtljlZuNpS2AiRczUBpnNcwRFmdoyqfEMMI7VcJpuAWHF9wLnc112vNjYhAD
	cT167s6vvWMAaF6pHzWU/yOppJ/cbiRT/jefx4dNtv5E+/KpXvj9vCMXRLDNCxZugepU8OmLTNQ
	nBjSwY144/7F6otbAgOiNtcBayvD7a2fYCS8RMZsabMLXIwd7OTG7eBzPX4z+TtM/gk9jTaUIyM
	b/GZvlvkU3lcg2XzLGkEoxObVBkSO0/SIjSYd8VNIvXaAbQYyP6cC6PKoGLphE9LqmJk0e7tty0
	/nNRmmV3NpLeGf1p+sA4YTnx+YuV9pG+//C1dMAvo0/Z88AM7qhXd3H5r1P6egDPzGSFSd2f3eB
	oermu8/LhS/F8sNyxQGqfjgtMbVh+qdgP/AYAghYjDDV7ofVvI9H+LN+QW040YCn2VPqIJbvezj
	hAHF/tTnvf98dpCCeg
X-Received: by 2002:a17:903:388d:b0:2ba:1c8e:256a with SMTP id d9443c01a7336-2bd30222968mr34932515ad.33.1778686170670;
        Wed, 13 May 2026 08:29:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ebe0e8sm182921245ad.76.2026.05.13.08.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:29:30 -0700 (PDT)
Date: Wed, 13 May 2026 08:29:29 -0700
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
Subject: Re: [PATCH net-next 1/6] atm: convert to getsockopt_iter
Message-ID: <agSYw5V5Z6Jbtjb1@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-1-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-1-fe7f0e756fac@debian.org>

On 05/13, Breno Leitao wrote:
> Convert the ATM SVC and PVC sockets, along with the shared
> vcc_getsockopt() helper, to use the new getsockopt_iter callback with
> sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
