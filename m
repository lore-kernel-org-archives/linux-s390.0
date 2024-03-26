Received: from mail03.softline.ru (mail03.softline.ru [185.31.132.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A7FEED6;
	Tue, 26 Mar 2024 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.31.132.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441978; cv=none; b=NJAZlYhDTm4/NVZR6sdqz/QxasBALtqzxoyGJtIb8ovHn00ErIElPQJoUqLppZ2wkTgKV9Ighu533+dd4w8vmPxV6+1eCo2mvObnLxPj/k7nJFoCwps7QXmQR56TFleIRrOkO0F0XebAzbcj+9oOF3Pkkmnkc3PG1ibl/U+oLeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441978; c=relaxed/simple;
	bh=+khCV1ORRWjue2vAhs6LLDgZaeQG/wO4Ggi2gFVAe30=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SlphoveXIdpadKm9SzzZr3OpkoR9rV/DFhbZXj0Zh1hu1COtBffwxlodz4cR1HlJahPdFH5wWl7XbNJ4FxjM1f6e4ZgyNjObB8afRnsca4VWccmxqy2p9mpI29J5l4t3Ej1Br04W9JtJobp0m5Sgy2nXes5NjbGSj+0zkhkvy50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=softline.com; spf=pass smtp.mailfrom=softline.com; dkim=pass (2048-bit key) header.d=softline.com header.i=@softline.com header.b=GZwnl0QV; arc=none smtp.client-ip=185.31.132.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=softline.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softline.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softline.com header.i=@softline.com header.b="GZwnl0QV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=softline.com;
	s=relay; t=1711441123;
	bh=+khCV1ORRWjue2vAhs6LLDgZaeQG/wO4Ggi2gFVAe30=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=GZwnl0QVLxEOjw2B9WUcXWgOxkrx157uG7SF6tuhK/4YEdBVMoG7Pe/fjicpz/Wda
	 8zD9THcCHR+6luud4VFzQAbCFrXTY7USfYaSjV+CtWK33MdMwrMvYWF9IKznW8jIvW
	 ZcRGt/uGy6NbEC9UznuvMcMZZGK/MCeoerl96MlvxMAAgwMXKNd03oAfYCeSKuINzd
	 2c248ieOuDi7fe5F4CwxKaqX6PmqM4XUUoUjleU5GKd7Fh0RyfI3RzgNqaCk40kFCJ
	 mEagjJLZ2DAkMvr44VRxz1sd430hIcuEqiltdU2xfcu6ClN4BD5R2Y4JBlvlPQ3+6h
	 JNJ58LW+yMKGg==
From: "Antipov, Dmitriy" <Dmitriy.Antipov@softline.com>
To: "gbayer@linux.ibm.com" <gbayer@linux.ibm.com>, "guwen@linux.alibaba.com"
	<guwen@linux.alibaba.com>, "wenjia@linux.ibm.com" <wenjia@linux.ibm.com>,
	"jaka@linux.ibm.com" <jaka@linux.ibm.com>
CC: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "Shvetsov,
 Alexander" <Alexander.Shvetsov@softline.com>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [lvc-project] [PATCH] [RFC] net: smc: fix fasync leak in
 smc_release()
Thread-Topic: [lvc-project] [PATCH] [RFC] net: smc: fix fasync leak in
 smc_release()
Thread-Index: AQHaZNb+eL3YMOb6v02FhrfSeOr3x7EXFu4AgBCQ6wCAAwYsAIAAOGyAgAEJXgCAAAaTAIAduhIA
Date: Tue, 26 Mar 2024 08:18:43 +0000
Message-ID: <941b129e87fec6b2f22ed3bc75334bd8515565a1.camel@softline.com>
References: <20240221051608.43241-1-dmantipov@yandex.ru>
	 <819353f3-f5f9-4a15-96a1-4f3a7fd6b33e@linux.alibaba.com>
	 <659c7821842fca97513624b713ced72ab970cdfc.camel@softline.com>
	 <19d7d71b-c911-45cc-9671-235d98720be6@linux.alibaba.com>
	 <380043fa-3208-4856-92b1-be9c87caeeb6@yandex.ru>
	 <2c9c9ffe-13c4-44b8-982a-a3b4070b8a11@linux.alibaba.com>
	 <35584a9f-f4c2-423a-8bb8-2c729cedb6fe@yandex.ru>
	 <93077cee-b81a-4690-9aa8-cc954f9be902@linux.ibm.com>
	 <4a65f2f04d502a770627ccaacd099fd6a9d7f43a.camel@softline.com>
In-Reply-To: <4a65f2f04d502a770627ccaacd099fd6a9d7f43a.camel@softline.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5829988BFE8C848B374725DCC6A8A00@softline.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI0LTAzLTA3IGF0IDEzOjIxICswMzAwLCBEbWl0cnkgQW50aXBvdiB3cm90ZToN
Cg0KPiBPbiBUaHUsIDIwMjQtMDMtMDcgYXQgMTA6NTcgKzAxMDAsIEphbiBLYXJjaGVyIHdyb3Rl
Og0KPiANCj4gPiBXZSB0aGluayBpdCBtaWdodCBiZSBhbiBvcHRpb24gdG8gc2VjdXJlIHRoZSBw
YXRoIGluIHRoaXMgZnVuY3Rpb24gd2l0aCANCj4gPiB0aGUgc21jLT5jbGNzb2NrX3JlbGVhc2Vf
bG9jay4NCj4gPiANCj4gPiBgYGANCj4gPiAJbG9ja19zb2NrKCZzbWMtPnNrKTsNCj4gPiAJaWYg
KHNtYy0+dXNlX2ZhbGxiYWNrKSB7DQo+ID4gCQlpZiAoIXNtYy0+Y2xjc29jaykgew0KPiA+IAkJ
CXJlbGVhc2Vfc29jaygmc21jLT5zayk7DQo+ID4gCQkJcmV0dXJuIC1FQkFERjsNCj4gPiAJCX0N
Cj4gPiArCQltdXRleF9sb2NrKCZzbWMtPmNsY3NvY2tfcmVsZWFzZV9sb2NrKTsNCj4gPiAJCWFu
c3cgPSBzbWMtPmNsY3NvY2stPm9wcy0+aW9jdGwoc21jLT5jbGNzb2NrLCBjbWQsIGFyZyk7DQo+
ID4gKwkJbXV0ZXhfdW5sb2NrKCZzbWMtPmNsY3NvY2tfcmVsZWFzZV9sb2NrKTsNCj4gPiAJCXJl
bGVhc2Vfc29jaygmc21jLT5zayk7DQo+ID4gCQlyZXR1cm4gYW5zdzsNCj4gPiAJfQ0KPiA+IGBg
YA0KPiA+IA0KPiA+IFdoYXQgZG8geW8gdGhpbmsgYWJvdXQgdGhpcz8NCj4gDQo+IFlvdSdyZSB0
cnlpbmcgdG8gZml4IGl0IG9uIHRoZSB3cm9uZyBwYXRoLiBGSU9BU1lOQyBpcyBhIGdlbmVyaWMg
cmF0aGVyDQo+IHRoYW4gcHJvdG9jb2wtc3BlY2lmaWMgdGhpbmcuIFNvIHVzZXJzcGFjZSAnaW9j
dGwoc29jaywgRklPQVNZTkMsIFtdKScNCj4gY2FsbCBpcyBoYW5kbGVkIHdpdGg6DQo+IA0KPiAt
PiBzeXNfaW9jdGwoKQ0KPiAgIC0+IGRvX3Zmc19pb2N0bCgpDQo+ICAgICAtPiBpb2N0bF9maW9h
c3luYygpDQo+ICAgICAgIC0+IGZpbHAtPmZfb3AtPmZhc3luYygpICh3aGljaCBpcyBzb2NrX2Zh
c3luYygpIGZvciBhbGwgc29ja2V0cykNCj4gDQo+IHJhdGhlciB0aGFuICdzb2NrLT5vcHMtPmlv
Y3RsKC4uLiknLg0KDQpBbnkgcHJvZ3Jlc3Mgb24gdGhpcz8NCg0KRG1pdHJ5DQoNCg==
