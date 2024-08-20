Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E518E353;
	Tue, 20 Aug 2024 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151766; cv=none; b=hMIky2kQFRQ95d6CdSJOWGwQZ/Aj8jClXb/b9tGaZ2y7/EGhQCo+ozcEMjUPbFmecvBXPV7BzI9QEzbK5nwXHIf4d0NyD8gJoDFPgZFe78zsSsQL/DkPz3hEpzfhLhqXzz+O2C8KTxD0Da7GECAhdGAhF6GlXnjQrNi/TQ8M8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151766; c=relaxed/simple;
	bh=uQYQrZjsaYT7acIpUT30+O5oZICeu4UgJbx3EGALuJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axQWDVRBCZ9CfDZxMvkcLftYZem7RHY0qeTW1JfSWjZfhlfvjGUQdBEkymaJRNvxuXwyxSpAfSWkTgKylTUs5uVNChquMTSX45JR4br4q3baypUU89/4OOINdroXSDScHlYvwg23zpXdqAG79fbLkjlN3pI0NgqzZa/CyJuWCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT6ZNQNN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT6ZNQNN"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d1c655141so3415979b3a.1;
        Tue, 20 Aug 2024 04:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724151764; x=1724756564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmPT77Y/quFeddBVsOtk7T+GuG6Z0L17u75DcnVPZww=;
        b=UT6ZNQNNorBCspk3Ef6VFcm7+/J4nCSZGIGqp0JKsvkVHwv/jb/oaGQe5FJxgrgSWX
         128MrgttFy/8OftG4oJjn6Ox4iiljdvRnFjBC83InOEXT7dyHzyfYaJ4rrF/nGRs7ZN1
         zd0OggIDbOv2EUdZyiftSkCC8Kz3cledt5QoMBjheRMCOtCKAMp3Yy2Baomt4Fp2RptA
         jprK1S9Lnv2sz0mdEIB8gQjzb2zFc4BynIwpbq02cMJ+Un8JHD/NgQS0RFfQDOVmtVsv
         ReP+aimTix7BXsqE2YgO6nwbqZwEWRq5lt006JExUlV+NcVV4SbujIVHb3tQOkHPI3o2
         +PLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724151764; x=1724756564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmPT77Y/quFeddBVsOtk7T+GuG6Z0L17u75DcnVPZww=;
        b=GOaCCVZB0gO2XQBQY+zD3S5mWrAyoQwRDqcG66uMmmjLBtnP9jAtxGkE6qM/VWpPrW
         UW6zYd0Tu7urtdjND5W1yfwLtmhKUPBS2hxQo2mxhGZAOXyaOGr4Blqj/mky0p2l0oHD
         7nB7ippsiNyz8RcnOuBUkcTBTMlPe7TOngTVc4nHZD6C3zcN+279+TrVSbqBrCk3SX7Q
         g676L/baAJ04yZKglH44+BzpD4ldyt/YOPCV6rEJZWh9o+ieDSBdemGJpnaA/UbQuB+E
         F9rre+OAg3nY3j+w33vXe4CtKsYHrS4QVVc5b0ALU2NCBsbMsokxZdDeq+E6wcNxXg8f
         9yHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWedRQGsxk51ET7vJy7eIFMm7YbAbE+jQ3QRgkj65Sw9yR7WWiHjKHuUAcYvSNEWkCT/YFkpnuc2iNRED73YpC4DCBaLf/7TrQ5LsTQoGX0ybcjmS/IlPp3Iq/MDNYa1P9qI+MABJdDAsFfU8jJMNBGDNaXilZ7UAxBgOm0b45iFA==
X-Gm-Message-State: AOJu0YxrXVRa3nFh1Q8Cm9rv3e8WSV9rYSzAio/OW8/62TyN5r9XZOA6
	E4a3hjj7qEpJw06iAcrDn9VXmn9JcHmL0kod98SJDlESuo/USAdg
X-Google-Smtp-Source: AGHT+IGqlI3VxLtLF0j5d3pyBa77+bDjYteUaPgeA0EbNaChZhsSDmi8hhA80aSB7pDOW4A2o+N5fw==
X-Received: by 2002:a05:6a00:6f03:b0:70d:265a:eec6 with SMTP id d2e1a72fcca58-713c4e73d85mr13372795b3a.13.1724151764268;
        Tue, 20 Aug 2024 04:02:44 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3d93asm7971220b3a.186.2024.08.20.04.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:02:43 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: pabeni@redhat.com
Cc: aha310510@gmail.com,
	alibuda@linux.alibaba.com,
	davem@davemloft.net,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	guwen@linux.alibaba.com,
	jaka@linux.ibm.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	tonylu@linux.alibaba.com,
	ubraun@linux.vnet.ibm.com,
	utz.bacher@de.ibm.com,
	wenjia@linux.ibm.com
Subject: Re: [PATCH net,v5,2/2] net/smc: modify smc_sock structure
Date: Tue, 20 Aug 2024 20:02:36 +0900
Message-Id: <20240820110236.338961-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e0f35083-7604-4766-990a-f77554e0202f@redhat.com>
References: <e0f35083-7604-4766-990a-f77554e0202f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Paolo Abeni wrote:
>
>
>
> On 8/15/24 06:39, Jeongjun Park wrote:
> > Since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
> > point to the same address, when smc_create_clcsk() stores the newly
> > created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
> > into clcsock. This causes NULL pointer dereference and various other
> > memory corruptions.
> >
> > To solve this, we need to modify the smc_sock structure.
> >
> > Fixes: ac7138746e14 ("smc: establish new socket family")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >   net/smc/smc.h | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/smc/smc.h b/net/smc/smc.h
> > index 34b781e463c4..0d67a02a6ab1 100644
> > --- a/net/smc/smc.h
> > +++ b/net/smc/smc.h
> > @@ -283,7 +283,10 @@ struct smc_connection {
> >   };
> >   
> >   struct smc_sock {                           /* smc sock container */
> > -     struct sock             sk;
> > +     union {
> > +             struct sock             sk;
> > +             struct inet_sock        inet;
> > +     };
> >       struct socket           *clcsock;       /* internal tcp socket */
> >       void                    (*clcsk_state_change)(struct sock *sk);
> >                                               /* original stat_change fct. */
>
> As per the running discussion here:
>
> https://lore.kernel.org/all/5ad4de6f-48d4-4d1b-b062-e1cd2e8b3600@linux.ibm.com/#t
>
> you should include at least a add a comment to the union, describing
> which one is used in which case.

Oh, I forgot this. It's a simple task, so I'll add the comment and send 
you a new patch right away.

>
> My personal preference would be directly replacing 'struct sk' with
> 'struct inet_sock inet;' and adjust all the smc->sk access accordingly,
> likely via a new helper.
>
> I understand that would be much more invasive, but would align with
> other AF.

I agree with this opinion and have suggested it to others, but some people
disagree, so I think it would be better to put this on hold for the time 
being.

Regards,
Jeongjun Park

>
> Thanks,
>
> Paolo
>
