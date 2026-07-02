Received: from mail-m49212.qiye.163.com (mail-m49212.qiye.163.com [45.254.49.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CAC29B200
	for <linux-s390@vger.kernel.org>; Thu,  2 Jul 2026 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979025; cv=none; b=rgQxwv/6EvJNuUFj8eiGpMvTag9chP85ezxqpaftNnvSrDsGuf/mMhe9u8j+OUbtYmDW/H+S8+WdjZRKy38EWOYa4yH+p0gUzgeQHQ+rXCpmyxyngsO2CkCyWrwccczq/hV8N9DPF1rd3B81Ltj/n32NLlPtst6AhadJhOU68Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979025; c=relaxed/simple;
	bh=bPYyaPMVGXJ6fi2007K/Cro/FnneDqwZ1yi13CzKCrw=;
	h=Content-Type:Message-ID:To:Cc:Subject:References:MIME-Version:
	 From:Date; b=WDdpn7aN+QoTTB/oo7JygdfMEq3OKqwqG5YLVRd0IZrhDFSc3j5IP3HK/rhq9NxXAApejCzpQIkROzX/1T/HC/vZ2Yqu9WkH+2PcOm4sRGsv9MTtkuDjk4Msomx6EsXQMFcTwbe73UdakinawfI/65uAxs3Vdv7PtJdNCYmQ8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=gqP9UK8s; arc=none smtp.client-ip=45.254.49.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="gqP9UK8s"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AIIAMAAiKrVMQaBAPYx42arb.3.1782978704726.Hmail.220255722@seu.edu.cn>
To: Sidraya Jayagond  <sidraya@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	Simon Horman <horms@kernel.org>, 
	Karsten Graul <kgraul@linux.ibm.com>, 
	linux-rdma <linux-rdma@vger.kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	"jianhao.xu" <jianhao.xu@seu.edu.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXRdIG5ldC9zbWM6IGF2b2lkIHJlY3Vyc2l2ZSBza19jYWxsYmFja19sb2NrIGluIGxpc3RlbiBkYXRhX3JlYWR5?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_WIN_1.64.1
References: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn> <17c1cbac-de30-4372-8c24-2acd755f503e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 220255722@seu.edu.cn( [223.112.146.162] ) by ajax-webmail ( [127.0.0.1] ) ; Thu, 2 Jul 2026 15:51:44 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Thu, 2 Jul 2026 15:51:44 +0800 (GMT+08:00)
X-HM-Tid: 0a9f21cf9b6e02f2kunmd5c2bf791f8cd
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMTUS6Y2fHkyPT6dc03QDwVaZPGiA09TnwhbhTj
	hLfuFZO94YXwX6xgvkjGVFFRKj5ODenkkczLo6qxkp6YADE5oPA+xgWdLLpCC0H84TwWSeGl6Gxd
	wNb5mLKCAhELViFYBc6UsltRrkd4duOKE4a1o=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTB5LVh0aSUofSkkeSkIaTlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVU
	pLSEpOT0xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gqP9UK8sz6mSaQSXwWUvX5IW1dCvOoLuzHheLSdx278rR0VZCmzeKQ+tZi/RiuVNKIzYmjvsiiKh3E2yVV1wA+FSjJRGHDbuUfYllhYz2Q+GWTO0qCqt/NhfA/mCQxFWWVdm+uvaLslyTHTIUaWGAPHcSoatnnArMxAxOhY6g+s=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=bPYyaPMVGXJ6fi2007K/Cro/FnneDqwZ1yi13CzKCrw=;
	h=date:mime-version:subject:message-id:from;

SGkgU2lkcmF5YSwKCk9uIFRodSwgSnVuIDI1LCAyMDI2IGF0IDAyOjAyOjI1UE0gKzA1MzAsIFNp
ZHJheWEgSmF5YWdvbmQgd3JvdGU6CiZndDsgSW4gc21jX2Nsb3NlX2FjdGl2ZSgpLCB0aGUgVENQ
IHNvY2tldCByZW1haW5zIGluIFRDUF9MSVNURU4gc3RhdGUgd2hpbGUKJmd0OyBob2xkaW5nIHdy
aXRlX2xvY2tfYmgoJmFtcDtzbWMtJmd0O2NsY3NvY2stJmd0O3NrLSZndDtza19jYWxsYmFja19s
b2NrKTsuIFRoZSBwYXRjaCdzCiZndDsgc3RhdGUgY2hlY2sgd291bGQgcGFzcyBkdXJpbmcgdGhp
cyB3aW5kb3csIG5vdCBwcmV2ZW50aW5nIHRoZSByZWN1cnNpdmUKJmd0OyBsb2NrIHNjZW5hcmlv
LgomZ3Q7IEl0J3MgdW5jbGVhciB3aGV0aGVyIGl0IGZ1bGx5IHByZXZlbnRzIHRoZSByZWN1cnNp
dmUgbG9ja2luZyBzY2VuYXJpbwomZ3Q7IGRlc2NyaWJlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ug
Zm9yIHRoZSBzcGVjaWZpYyBjb2RlIHBhdGggaW4KJmd0OyBzbWNfY2xvc2VfYWN0aXZlKCkuCiZn
dDsgQ291bGQgeW91IGNvbWUgdXAgd2l0aCBleGFjdCBkZWFkbG9jayBzY2VuYXJpbyBhbmQgaG93
IHRoZSBwYXRjaAomZ3Q7IGFkZHJlc3NlcyBpdD8KCllvdSBhcmUgcmlnaHQuIEkgZG8gbm90IGhh
dmUgYSBjb25maXJtZWQgY3VycmVudCBtYWlubGluZSBjYWxsIGNoYWluIHdoZXJlCnRoZSBjYWxs
YmFjayBpcyBpbnZva2VkIHVuZGVyIHNrX2NhbGxiYWNrX2xvY2ssIGFuZCB0aGUgVENQX0xJU1RF
TiBjaGVjawpkb2VzIG5vdCBjb3ZlciB0aGUgc21jX2Nsb3NlX2FjdGl2ZSgpIHdpbmRvdyB5b3Ug
cG9pbnRlZCBvdXQuCgpJIHdpbGwgZHJvcCB0aGlzIHBhdGNoIGZvciBub3cuIFRoYW5rcyBmb3Ig
cmV2aWV3aW5nIGl0LgoKUnVueXU=
