Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24B34EF1F
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785575560; cv=none; b=Q7N5Nd1wASJK0UEM7Iu1DrihuIK/YwSIVptgOvOoclM0nexwA1asGgSJt8bJgxTPXpQ4xf/LSyrbXqgudq5ACY7howYgfz8yMroOSLr+PTNMm1mTijbIInQIED6V2GDa72IclLIrV3OWloHSwCInhLJed4UvXDl+gzU/7TG59Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785575560; c=relaxed/simple;
	bh=WtKwboX1I6TACBp1mPchjcTdLWsllHrSvbiZnJsT49c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSdf0ug+rx5Vb1c5G/gU4iD9JuVgYV4T3wEoy/GocP4/mTBnoYTl76VcWCjjY45BgI4S04nqXkMexSzianjvS+4pcRSvcf4n4qqLocpHQnfLx1qLyI960WM0jTU8AxevI0jyPmnleAQK2nEto2YscvVKWzAaPbWIcs1G9S80R/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=kSvakdbn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="kSvakdbn"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccf2360620so15525375ad.3
        for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785575558; x=1786180358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=diW7eq1K5OgM1EddS3mEle0ywoNtUEUmAHB/nUoYXXI=;
        b=kSvakdbnTPxX13Fpn/tWdUQm/L1zgBFHeQP+9rBJ/Z+5GVEdk6SEZ9AUkVzTCLt50v
         oC2Kaf1hsHNNfuGi0CfdOAWueL2qUo8A+NAVW4PZaMfAQ2tnU1/OR9zkbkfh9eawkpu9
         KHEe7kU0bhSP7msuvbpaIwbvLt/fITbGxzFrft+07FVLADbJ3gQBsyJBDbHT/ipDRqmB
         OMkuU2kES6d00ESeMVUwO2lxvoHpj05ERSql8jhl4EpRCoTEBesPBhNTeATpryL2d7cM
         IrJ6XY1vLztQ3Zeg2uyTV8ZjnD/nwZBaQbjT4xQnSjzTeQ3RXawZATKQXMyCytRJBk43
         TbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575558; x=1786180358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=diW7eq1K5OgM1EddS3mEle0ywoNtUEUmAHB/nUoYXXI=;
        b=Km42xZ0fs0/8cS4HNVYbwiiV5onXRCP0o+1UOrSsrdQ4FdEaaGOiHTEleUAtaKs7rM
         NvqvKWAMsWn2gc8HbY/54MGiVOAFhuZvfy0pbD4xes8OByYRrXcqfbdBkgbBhwooSW5I
         MaERvTCJyeD+Zdd6ppMAsONf1oc6T07CYnsqB320NGMh1zW5eVREC+s3m1Y2l9aw62AJ
         t0j0JnfOhn8bU05uEKqTCygEeq/b+mNVxcCzkucm3q8uvRDsZxDHEnrn/KsCaHRuVEtJ
         N1zNy3HtylmrwN7B4TRkeML0/I4LWHwxN8A0ckAu+/A68Wbb+G0S6iA6eesK+YvReJqb
         6ZyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrk7dRxjU78zP5XuHAvlFx/roxyCVpPb63obvxl3+l7fakg6XmKvD27KkI4Nb/wd3mbrtyj8Z5yLfwo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3tTkISGDA2guMUBsBqTypMCNg5SdDUwTx6KrusLVZauR6ty5/
	54zdYX9+4i0WCacR6RxLXavO1sIj/0Z71hKLkpCyeOIRLgIN3mfW/4tfnn0UygWEPA8=
X-Gm-Gg: AR+sD11MLA6kroSt8K7Yqtn/q+OYsPl06JM3SBLYU88TpPjzDCqPSPNWHU1uAN/ey/I
	dcbcFu/CUDeWFvtD5Pr8Wi63SVU25ViPhObkxe45zY1BYAVNZikiVQXVvj+gvyD5O2QLxjOwLod
	NZJlG9P9T5cxyBbf2vXFZ3MynUW2L4CNkVrAw7CCMTSv+0aSmoWbRR7rhlJ+PLOHgiiCoWy4JLr
	UUNJTDvidd1d9dVJsVJhXMje90rBQB69jM1cLpMx2NWCAjfcbghFIWgizSlnGsqS6YrgHmffRJ7
	TNN3jP7hSlOvpwrad/2O/Uj6eBM3ACBvmTdgomvKPK80B8/ZKag2nyIzKMpTfWh+4qKXkpChflm
	sKdOqjs6bJOJ0RQZMsWXSWLqtXIJJIWoQAL0Q7tKpBwQfkKp9XmbAYlc1x2VjmFmlxUN6DbqWfS
	RfUs5er6h6Qz3TDfr7otxpPlK8VJg7AOLba8fZGSr6thxrzis+KlBGD2tqgKzGKCEmsulUFTMlL
	rI4NFGU+lk=
X-Received: by 2002:a17:902:ebc2:b0:2cf:bf32:b754 with SMTP id d9443c01a7336-2d05219f1cfmr29858925ad.8.1785575557981;
        Sat, 01 Aug 2026 02:12:37 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae60139sm16175285ad.29.2026.08.01.02.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:12:37 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	sashiko-reviews@lists.linux.dev,
	horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	agordeev@linux.ibm.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/3] net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
Date: Sat,  1 Aug 2026 18:10:47 +0900
Message-ID: <20260801091109.1933145-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801070548.365231F00AC4@smtp.kernel.org>
References: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr> <20260731070509.1818665-3-yhlee@isslab.korea.ac.kr> <20260801070548.365231F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sashiko-bot@kernel.org wrote:
> Does this early return cause a permanent protocol failure for devices
> with a single receive SGE?

The buffer part is right, but smc_llc_save_add_link_rkeys() does not
read that buffer.  Without a shared v2 rxbuf its llc_msg argument is
&qentry->msg.add_link, and smc_llc_enqueue() copies only
sizeof(union smc_llc_msg) into the qentry -- 44 bytes, which is where
the extension starts.  Same for the delete side.

I logged what smc_llc_fill_ext_v2() writes on the sender against what
smc_rtoken_set() gets on the receiver, over rxe with max_recv_sge
forced to 1.  Unpatched, the sender wrote four distinct rkeys and the
receiver called smc_rtoken_set() 427 times, not once with one of them.
With 1/3 and 2/3 the path is not entered; with 3/3 as well it registers
six values, all the sender's.

So nothing is lost -- what mainline registers there is heap past a
72-byte kmalloc, which is the out-of-bounds 2/3 fixes.

The changelog is wrong to say "nothing beyond the 44 inline bytes was
received": it is received, it just never reaches the queue entry.  I
will fix the wording in a v5.

Best regards,
Yehyeong Lee
