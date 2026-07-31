Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D733E37C
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481528; cv=none; b=SwdbJXDXW8s8IaQMPK0l83B0vS7IrQvFNaFLN8+0+/EzWIx+m/uUr3gesZtQgkaYp2bheQemmuP91SaXYJvKE0ouQx8mbJ8ioEHkq4JDE1oxhzYBDV8OYbFObQo+6ch70pHWODzqjLnRglxsfDBcbWgLK2dS+KtP6hrzbLYkasg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481528; c=relaxed/simple;
	bh=NqOoRdyRQwEnHaciOW1Lo15WOzVkPW8i+CqT++jomdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGdwvtkpqJP81jF4bJCeX7mNx+yzIsXcR1CXsJtHwPO92832I/1SAj2BNSlM41UTuCNHPynNCH9wBKKbnqDBboH3s0ddOuPZUH4RRJKVJiTxFcBISMUQiLwdxKElO2bdc06e9Bie2p4EiSJpoUaNtZCy+BDEC6z2uK38Vl4pevk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=c0GuwMPd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="c0GuwMPd"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8423f236418so598327b3a.1
        for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 00:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785481524; x=1786086324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MXV9qH7UyhntE49tPsJBkiOVAaJG6JngpHeIAflWXR4=;
        b=c0GuwMPdOzqJUAGYdqnoaooYfpNFhiXhzAtOfICyJYNDQ0N9GjM/XAyjhTCF9HuiCe
         RYDC1I5LShs4tKGl9fMRjq0JQxROozcHjbT0gQKIi4GeHo1k7IT4N1Wif8CrzqmoaSgw
         lzf0KoAO3KpFlhOyK3gmptoTwOMyR7v2DOXyLS+tDG6KrUZLC86Kh4gry1FEq6gt4HKi
         qZi2cWJcgDtZVKDcueW91EWq8PYtjDkBoRYi8l+M4D0Sd0gODHh9UkGsGAhNBn9jtFpP
         Hgi8sgqDJpVT0Ms45t+OTAcI/RqVnZXZm30rfjIc+LeBPwUZrG/+nu2K5PMZOW5B7i2i
         TRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481524; x=1786086324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXV9qH7UyhntE49tPsJBkiOVAaJG6JngpHeIAflWXR4=;
        b=m+lTlBRvU0P2yqaXsthpNVP9T/ciVwTRcFhTPXGhJZTNdVkLv56L4Ootqfpczcydej
         68tJ3a6ntFBL8TbDOBCZuKJOos5hiVuGp7Yrs3Z+GrXJMT059UzcETYqcqbSZ6a2dp+o
         49Kks/4KoBd+AyfPhB3J5zsqXTbw3uMscgHCRSdFJww43ESMZ8H3n1l1kXCZhBLLyySZ
         ccvMhrLeiIVVVl67uaqxyvgrW0TgzZNlr1/bwCNGqfEDR7ssF/8r0nL++KXxbn4y6TL+
         q8W2uun7wFp4QWzy3iWgOqnijie93GWHoSJG9UDlYCMGE9SJaa3Tkibg7lKo9rXLYCNU
         sL/A==
X-Forwarded-Encrypted: i=1; AHgh+RqVJtjn0BrJfgE+/Hf20cEWEt/EoVItejmP4IkryMlClJNzPstG/goMl68TtqxHkihgSdn043VK8gwN@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ1XujhRhcSMwq+MqZ5/Lo0t0FDdij79VTMJ1J5aUZkVjP2jyP
	Nvm/qLmzrA3JI9XlzAii6G9c+1ApaK8Lci4RmQ0iIu9Otj+Z4UqHCdHdzsmeScRl6eg=
X-Gm-Gg: AR+sD13Tgzd7XAFLnAG3mrJTQIm43uJr0q3WS+gE5xWJ/JGHaVbTaeodXDAwHRImJwf
	qeRGZWqJ50MRBl2bgoFN/YK8fSJ5/dEH+mkEdjHl+/jkcUj+tSAxE4uZ8oYqxco6n6GA3HWhKVx
	vDOOJVb2OiQYdWtfvJyeCm/VXllNaSJrzxM/eAVlvxSEI2/awYMXvemU9ODoN2upBoEKtZdRAHO
	wxIOqlxJ9vtHiLqupEWUT2X38ZDqNYa82KR7c1AqPSDz2Xsm7DYhbL8w/EahKmeroTB7d/YHUpE
	uemc2lCplSKC7egbf8NJIDY7qY1cIZa39zb+czE0A1Z/D552FpHYLBzOR8WNW0jzaqq8ncnoAxv
	ZhwDCswIdO19R/EyGVJF9sCv0kZHMTjXhrULrvfANO3TvmSxek9Zn/+KDZEs9lL0Uy7WMBHZdk1
	s0FySkvefFz2KfoGe4iuUZFPMnR6J/fVFwQKXMXo+BE1sepBpp6sebmuj2O064icZsquTf
X-Received: by 2002:a05:6a00:3e1e:b0:848:5935:2e11 with SMTP id d2e1a72fcca58-84ed7266716mr671512b3a.48.1785481524374;
        Fri, 31 Jul 2026 00:05:24 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm39233b3a.40.2026.07.31.00.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 00:05:24 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v4 0/3] net/smc: fix out-of-bounds and use-after-free in SMC-Rv2 LLC processing
Date: Fri, 31 Jul 2026 16:05:06 +0900
Message-ID: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split of the single v3 patch, in the order Jakub asked for:

  1/3 frees the LLC queue entry in smc_llc_srv_add_link() only after the
      last use of the pointer into it.
  2/3 bounds the peer-declared rkey counts in smc_llc_save_add_link_rkeys()
      and smc_llc_rmt_delete_rkey() by the buffer they read from.
  3/3 copies an oversized SMC-Rv2 LLC message into the queue entry and
      declares the rkeys that fit inline, so both consumers stop
      reconstructing the layout themselves.

1/3 and 2/3 are tagged for stable.  3/3 is not: it does not fix a crash on
its own, and it changes a structure layout and a static function signature.


---
v3: https://lore.kernel.org/all/20260727095833.1079618-1-yhlee@isslab.korea.ac.kr/

Yehyeong Lee (3):
  net/smc: fix use-after-free of the LLC qentry in
    smc_llc_srv_add_link()
  net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
  net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry

 net/smc/smc_llc.c | 101 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 25 deletions(-)

-- 
2.43.0

