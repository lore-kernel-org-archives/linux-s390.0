Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DFB38D69E
	for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655034; cv=none; b=Guq1hxXrFewlj5euo7cPIar+iPGtUURLgU3NVg4dy831vl7p5ho+kGy6hnTL/3hUDMlgjFsxoO8pFfeX9Pj5REYaD50iNN96g8yFal1e00zI00RJ3Y7ch1dLwoQoZiGCoXxxK18nslRBLrrTgjoLffcpsRi/cIJMRrnw2RksRwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655034; c=relaxed/simple;
	bh=zJBOLQiuRuIGJWm+7NtMtPvsKlcOH7ynxMQD9ByjJRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r2DjoL7FmlZ8zO5hSInp5fBMkaBzFwTpHdI1krA1SYMly7OTxdZpxoQCCPh+zHkzjkkC6V52yh6VgnuAzKvhYabA0Z1yynTeBgkn26XSLRcAz4qW9B9cM5J3KkfSmE6OAHd1PAgTdyZbPPjeZZ+cMrFdKs5dNs2kUc0B7hx1oC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>
To: "freude@linux.ibm.com" <freude@linux.ibm.com>
CC: Holger Dengler <dengler@linux.ibm.com>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbUEFUQ0hdIHMzOTAvcGtleTogUmVtb3ZlIHN5?=
 =?gb2312?B?bmNocm9uaXplX3JjdSBmcm9tIHBrZXlfaGFuZGxlcl9yZWdpc3Rlcg==?=
Thread-Topic: [????] Re: [PATCH] s390/pkey: Remove synchronize_rcu from
 pkey_handler_register
Thread-Index: AQHcsqmAvVMh8VNLlkm3NXBkRNwdp7WwZRWAgACK/AA=
Date: Mon, 16 Mar 2026 09:54:51 +0000
Message-ID: <a9e2b8ec60f64374852f62fc90e85e36@baidu.com>
References: <20260313052312.2389-1-lirongqing@baidu.com>
 <09877680c056890694067390894f2e01@linux.ibm.com>
In-Reply-To: <09877680c056890694067390894f2e01@linux.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.50.46
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBBZnRlciBzb21lIGRlZXAgZGl2ZSBpbnRvIFJDVSwgYW5kIHNvbWUgY29kZSByZXZpZXcgd2l0
aCBIb2xnZXIgd2UgZGVjaWRlZCB0bw0KPiBsZWF2ZSB0aGlzIHN0YXRlbWVudCBpbiB0aGUgY29k
ZTogVGhpcyBpcyB0aGUgZmFzdCBwYXRoIHRvIHB1c2ggdGhlIGluZm8gYWJvdXQgdGhlDQo+IHVw
ZGF0ZWQgbGlzdCB0byB0aGUgb3RoZXIgY3B1cy4gSWYgcmVtb3ZlZCwgdGhlIG90aGVyIGNwdXMg
bWF5IGdldCB0aGUgdXBkYXRlZA0KPiBsaXN0IHdoZW4gdGhlIFJDVSBjb250ZXh0IGlzIHN5bmNo
ZWQuIEFzIHRoaXMgY29kZSBpcyBpbiBnZW5lcmFsIG5vdCBwZXJmb3JtYW5jZQ0KPiBjcml0aWNh
bCBhbmQgdGhlIGxpc3QgdXBkYXRlIG1vcmUgb3IgbGVzcyBvbmx5IG9jY3VycyBhdCB0aGUgZWFy
bHkgdGltZSBpbiBzeXN0ZW0NCj4gc3RhcnR1cCB0aGUgZm9jdXMgaXMgb24gY29uY3VycmVuY3kg
dmVyc3VzIHBlcmZvcm1hbmNlLiBNYXliZSBJJ2xsIGFkZCBhDQo+IGNvbW1lbnQgb250byB0aGlz
IGNvZGUgbGluZS4uLg0KPiANCg0KVGhhbmtzIGZvciBleHBsYW5hdGlvbiwgSSB0aGluayBhIGNv
bW1lbnQgaXMgbmVlZGVkDQpzb3JyeSBmb3Igbm9pc2UuDQoNCltMaSxSb25ncWluZ10gDQoNCg0K
