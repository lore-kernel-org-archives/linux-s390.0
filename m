Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E243F4921AD
	for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686221; cv=none; b=kL7F7/FZToQPCMv5pVrMDDgRB/GyOmucXpMlKj+08g4/tHxQqVMZUqy7ytbgVzhci1gvw6C4ajX+TX8TmqJYJuP1UJLYZJb6M3UoXg1N6KpnZNOFPe4CWsX/MR4XEQvGu3ftTr45qa9DLo0/y9cAKggTsMdwlhkRVDYu7i5aoRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686221; c=relaxed/simple;
	bh=Rd7C5pIyq6OPAFpxl7D+tvMh9VkGH7FniJDQxl22aEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceUTrLzVwyTE9VPPYn93rP35Iwk10EfSgdi7yiQvyW0umCWx8D9DJzYdpXBmJC3P2Gu6TpVHGX2+KO2dfRAbDxzLon2KuXhgz5qXylB2iYZYvDb0cVF7NO3v6yYFoHfVW3I6VPVZemD9gqXYjHd2geIp7YzH9NeY6Al2CX27enw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK1KqgKV; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK1KqgKV"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-83538fbd0b2so2798211b3a.0
        for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686219; x=1779291019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPiUqnotsQbH12PdnNU+eakW9jTUpN3Bb+mdu+U6uUI=;
        b=XK1KqgKVKKahwbs+G2BluT/VTSOjPO8KWsoSKiGZQHNeovUR+vI8A+3ezj6Xhyjtgd
         tn1ttCf8QE/IRZs9ukC834PMS4LgYqUjZqwnk/fDp7DeM/bmVkbDItLVJi1pc5L+P0tm
         dQGYjscyxFXCV+bP/qq3eV5DZBvvZbC3PWH81m2tJxuGSFEALflJioLrl5I250cSTJRX
         igUM4RBGnYdS0UcRnFYGmV+EhlKyviak5QL+vvpU4mgj40/w4U5+ulm6pMj+lYCB47ar
         jdlqPSDtZkcLj6Q7f0ldV8kjAOnFkoMsE+Aq8el61PFDmfRh03mxMkuHi9Q+zH8r1X/0
         C17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686219; x=1779291019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPiUqnotsQbH12PdnNU+eakW9jTUpN3Bb+mdu+U6uUI=;
        b=BNYdK8AcjrqEgr1ubAjsPYgVvBc+N7fBsJ/ZKLy//dQLzpxq4/vv1s2QQXBajTiwSU
         qZnpOE70gPxlMd6WN+FFdWq8brEq+PDTKjAOZjlV+Nbwpp/tT1WFQ/XLeeir56HZNlz4
         QsIk3gFfl0FhnUEFsvX4T5iolvmSD4w6E1rucLYBTe36RAiIwza0xBqHziUs690mdBGx
         z5qbYeSjr7Vc0GcVJi3yARra+mKO0PGl7ddKlU8ww6kTiS0TWktILQbSeHWtVRTUCDWT
         39Sz2UVwIpPWDaQ0Ym72zrMIV4MhiRPl0XF2dwZRa63TwEcgR6wZbFUJ5D5s6Y29gt6f
         iRkg==
X-Forwarded-Encrypted: i=1; AFNElJ9HJm96/RgRNt8+o+RqZ9gLkbbc3SokUDP2TO3UvU/+omVjRzYwT137nesnJ5dEa+Rb58KHUkrX1O4n@vger.kernel.org
X-Gm-Message-State: AOJu0Yy533xnfw2iqRn0ExXKZDRF2Pyb22dGFCsXnwyJS8lL0nbi0c3d
	pdJKwS6EAcVYj9xlAzdvu+5/1meaGzHKCDdAkHk74Kdm+97ho8eCm62/
X-Gm-Gg: Acq92OG7pEjvLK+X0G0FAHAinOLn7oc4o8ysX5Sp+ZwIrn1lxJLFgGO0etpQPAsE11n
	WdyvOdqgjQGNpXG3gDqNwK/Kk0WV+HVWvVKui1WidvOtwt7TsyUXKf61VeC7H8GfzXzC45kg+Lt
	jQyXNWOQ+29AuqyGvIbm/UwY3QmCeN1PQnkKE8r62wquflm4x/VGEnE7eUA+X0KfsSK1cbj+z6/
	zG9N7v7K0xQT3zDFhCXYU1iS52c2Xu8KIWuExabg0eWe247sfj30Z1XsdFtGMWFG9Zx4HwOBe1p
	HKf2mstW09/Roo+yNcwFW04WDqJMm55FQN7CwcZ+rFdFYEB3Jao3Vzm0c8LtfNw8CW9VClJh+2W
	JyUR9JRXXQZQ1MhyWtGil96k5eKYFof2RZmcXlC0ntZ721gtNfeI0lqFn0chiVJqkbkZCcuRxtS
	w74r7kewexnvpZI6M0
X-Received: by 2002:a05:6a00:22c7:b0:835:3730:571e with SMTP id d2e1a72fcca58-83f03e91a86mr3976162b3a.5.1778686218924;
        Wed, 13 May 2026 08:30:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf0cesm33281534b3a.46.2026.05.13.08.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:30:18 -0700 (PDT)
Date: Wed, 13 May 2026 08:30:17 -0700
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
Subject: Re: [PATCH net-next 2/6] xdp: convert to getsockopt_iter
Message-ID: <agSZAkPavoKMEF-K@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-2-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-2-fe7f0e756fac@debian.org>

On 05/13, Breno Leitao wrote:
> Convert XDP socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
