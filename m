Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730FE1B3F25;
	Wed, 14 Aug 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647967; cv=none; b=mZ95FJWjKh14HUYG4v0ImcJ4vPSKpfqD63rcvNtWPA/GLB+Fc3Ps9nS0+/sL6l7pMKsS3R204y5PCS/n2izDFd1KmBHXqq/2lICOhBxb6t96iQmTFuIH75k/40W4fwdW2pm/5RAYogxn9diwGKJmZ3ASiKl+SCRcMAllFbo5iAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647967; c=relaxed/simple;
	bh=8cK0GvF5QFceshCvw1XcYlJrjfm3NLa//F8dGczr9ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pq4UKPT5HuQQBAr+FkaoKUsFyKWKvJfeQIeCVMFA3inN9VmheMnzJjrFndMTPP2zksXAmkdwBK4AOgKWn7iDI0z1gST91/4xQaUZjME23rTs1PMmiA3W8VtgvYMxy0Qp9mwZffV791KqGoHszRTTkjR2jtOS9CeaF2E1Vg8I9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo8Pr/Gg; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo8Pr/Gg"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71275436546so147935b3a.1;
        Wed, 14 Aug 2024 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723647965; x=1724252765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBNNXqbtdbYFsD6uUrAH/OBdUYwLKiBcMh/OK4+Ox7A=;
        b=lo8Pr/GgxyuPfLeUK/umgoYFUZK5tUXYSdZYuNggW//zHX68On+LkmORQelEWYAUX8
         eY72aUYnLLprhuK+AN2q9uQT37mLstTQ5JJBWa+voy3Sn0/NYnKpqg6bpaP3q53Tpzlz
         4QgDmpixBL1Y6s4jxW+08B/FHLmSOBGSgb7Uk3RDyJNvQGp+lggBCk/q6gVcV8kYNNPd
         yQc4HQrMt9ArL9XTZPC/GnHjYKclWK13fkey93cxUxll8VOv3j5JhYPn/Bu5RGww0JWi
         sYokc8/Kma5lCm0XtGuIuhpflc0LOpuL8RRihjHnSeFLfY500YV6VjZZ1VQX6KGx1HZ5
         F9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647965; x=1724252765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBNNXqbtdbYFsD6uUrAH/OBdUYwLKiBcMh/OK4+Ox7A=;
        b=bpJXwmckvOL7WlPtHrlXxT4z7zFUkGG1gZXMeChP8OoFnFdBj2tgQLxJze9tf99WCv
         3RmBmY9ouPkU+JjaCFflSgqkZu70kJymvYQO3mlcoDTp39Jr4fIMq9v51sM2bzttZ3j0
         MyGBwttDdMCJXpqvnowO6kPOkfLTLglaGj1R0CKqyqzuh1p+SpJsdRgDCmGIA/+i13nJ
         YhKfoH7L4CBcTX449f3omewQ66oUgNmKxZLP6I/eQt0FvZT62qSqccVoCGZQlWQGmTAq
         ReKNdyfx3rg6bGnegjBAH4pxaDGLdn3e1JRNF23WlD6M7RkgotWhWn4Bl7fY8x9ciMwp
         155A==
X-Forwarded-Encrypted: i=1; AJvYcCUzI9LgZOwLxLQFK8dDNqC0buQlBDfOBoC4ciRSlqn+COKxQd302qGR71L1ubxaRiVrCOBV3nR1QKxK2vfWvi/ubntTMP0kWiG21V7IIHv9O70MwePOyp+xYvKFkOKa6gttH6e9eweMf6uNiTPD7reyt2ok3eDte/jPMaRYlvs6Iw==
X-Gm-Message-State: AOJu0Yw7ZS6wpPL1BPNSjxBYtbp0jGLsjetvbe9jFtOODzfU7tvjTWsv
	8mZb2sIOAN3RzJOkLWasWr5/LP/ayBvpK7cF6HV+5mQh/OUtY1T4
X-Google-Smtp-Source: AGHT+IG6NXju3u9uZ1M2mdalYsZOqTUXuZluM3xmOKU+R9fWBY3JxN9QRZVLpL2g6H83xxWtFjtB2Q==
X-Received: by 2002:a05:6a20:d486:b0:1c4:ba7c:741c with SMTP id adf61e73a8af0-1c8eae811a1mr4098557637.21.1723647964422;
        Wed, 14 Aug 2024 08:06:04 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7126ad714a6sm1236278b3a.186.2024.08.14.08.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:06:04 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: wintera@linux.ibm.com,
	alibuda@linux.alibaba.com,
	gbayer@linux.ibm.com,
	guwen@linux.alibaba.com,
	jaka@linux.ibm.com,
	tonylu@linux.alibaba.com,
	wenjia@linux.ibm.com
Cc: davem@davemloft.net,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net,v4] net/smc: prevent NULL pointer dereference in txopt_get
Date: Thu, 15 Aug 2024 00:05:58 +0900
Message-Id: <20240814150558.46178-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <64c2d755-eb4b-42fa-befb-c4afd7e95f03@linux.ibm.com>
References: <64c2d755-eb4b-42fa-befb-c4afd7e95f03@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexandra Winter wrote:
> 
> On 14.08.24 15:11, D. Wythe wrote:
> >     struct smc_sock {                /* smc sock container */
> > -    struct sock        sk;
> > +    union {
> > +        struct sock        sk;
> > +        struct inet_sock    inet;
> > +    };
> 
> 
> I don't see a path where this breaks, but it looks risky to me.
> Is an smc_sock always an inet_sock as well? Then can't you go with smc_sock->inet_sock->sk ?
> Or only in the IPPROTO SMC case, and in the AF_SMC case it is not an inet_sock?

hmm... then how about changing it to something like this?

@@ -283,7 +283,7 @@ struct smc_connection {
 };
 
 struct smc_sock {				/* smc sock container */
-	struct sock		sk;
+	struct inet_sock	inet;
 	struct socket		*clcsock;	/* internal tcp socket */
 	void			(*clcsk_state_change)(struct sock *sk);
 						/* original stat_change fct. */
@@ -327,7 +327,7 @@ struct smc_sock {				/* smc sock container */
 						 * */
 };
 
-#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
+#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, inet.sk)
 
 static inline void smc_init_saved_callbacks(struct smc_sock *smc)
 {

It is definitely not normal to make the first member of smc_sock as sock. 

Therefore, I think it would be appropriate to modify it to use inet_sock 
as the first member like other protocols (sctp, dccp) and access sk in a 
way like &smc->inet.sk.

Although this fix would require more code changes, we tested the bug and 
confirmed that it was not triggered and the functionality was working 
normally.

What do you think?

Regards,
Jeongjun Park
