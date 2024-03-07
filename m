Received: from mail03.softline.ru (mail03.softline.ru [185.31.132.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E233185636;
	Thu,  7 Mar 2024 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.31.132.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807724; cv=none; b=Vr6tSzNalLH/76cu/ZZAfjQx13qIm2C9h/ydF3zeWlVVYl3R9ZuL+LjXVItXCpZdu9uJBBd3IGc10LiipPxgTn5zW6Ux/xlkpYvlMd8BL7oq5U/531wdnZXNjHzxygBEUoVBQfsliBmQe+JfdG/NZlCVuX2MjxLUHTLBXK1D7Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807724; c=relaxed/simple;
	bh=GGNVKkgS6wBOf0BqLNzDi9ywxg4mj96PUG/i4B1ak6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QrVf0OViThWTTIXpq8VixQqu1PCbzCbkoK+9kzI0wlX/O9hoE1MXjdblibjTJByUcbPpm13bYtItUcSWNcKQ8WQyexENLZSAgK4VsiH7gpLmfSvhatE2d+dOQl6KZN+BxLRpa3OjaggkWncDExjSUndbxXOZDnJpqKizZcSoYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=softline.com; spf=pass smtp.mailfrom=softline.com; dkim=pass (2048-bit key) header.d=softline.com header.i=@softline.com header.b=OJ6F57S5; arc=none smtp.client-ip=185.31.132.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=softline.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softline.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softline.com header.i=@softline.com header.b="OJ6F57S5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=softline.com;
	s=relay; t=1709806874;
	bh=GGNVKkgS6wBOf0BqLNzDi9ywxg4mj96PUG/i4B1ak6c=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=OJ6F57S5Q59/pbEAPruMYxu53IuGUxT+pZEuzRfiqqYEOvO4B+vf0DHIiL8KOkj2s
	 9XSWMZUNrwTg71MVBhyCelgvoa3G/cpcH9+/VcokM/DBZdyAEEQHb+zMKoTJNeCTuy
	 tODdgMesu3PPfGB5C3hhxgCq6m5p3B9Wu/NQNplapGeUbyh19cMUO4lRfqw6g5OrNR
	 2xo+Q0cNlpyQ6wRyeOPJcC6EYCj5Hb1vZZUlL4OpateJc2rtvW85kxn128YJ8n8mn0
	 NBsjERpSr6yBvqNTXV7zLZ764dACswt8bPbd03zsxWTzXQUGxfKENr+tK3DR0CVDd4
	 ECWZlHm12kqzw==
From: "Antipov, Dmitriy" <Dmitriy.Antipov@softline.com>
To: "dmantipov@yandex.ru" <dmantipov@yandex.ru>, "gbayer@linux.ibm.com"
	<gbayer@linux.ibm.com>, "guwen@linux.alibaba.com" <guwen@linux.alibaba.com>,
	"wenjia@linux.ibm.com" <wenjia@linux.ibm.com>, "jaka@linux.ibm.com"
	<jaka@linux.ibm.com>
CC: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [lvc-project] [PATCH] [RFC] net: smc: fix fasync leak in
 smc_release()
Thread-Topic: [lvc-project] [PATCH] [RFC] net: smc: fix fasync leak in
 smc_release()
Thread-Index: AQHaZNb+eL3YMOb6v02FhrfSeOr3x7EXFu4AgBCQ6wCAAwYsAIAAOGyAgAEJXgCAAAaTAA==
Date: Thu, 7 Mar 2024 10:21:13 +0000
Message-ID: <4a65f2f04d502a770627ccaacd099fd6a9d7f43a.camel@softline.com>
References: <20240221051608.43241-1-dmantipov@yandex.ru>
	 <819353f3-f5f9-4a15-96a1-4f3a7fd6b33e@linux.alibaba.com>
	 <659c7821842fca97513624b713ced72ab970cdfc.camel@softline.com>
	 <19d7d71b-c911-45cc-9671-235d98720be6@linux.alibaba.com>
	 <380043fa-3208-4856-92b1-be9c87caeeb6@yandex.ru>
	 <2c9c9ffe-13c4-44b8-982a-a3b4070b8a11@linux.alibaba.com>
	 <35584a9f-f4c2-423a-8bb8-2c729cedb6fe@yandex.ru>
	 <93077cee-b81a-4690-9aa8-cc954f9be902@linux.ibm.com>
In-Reply-To: <93077cee-b81a-4690-9aa8-cc954f9be902@linux.ibm.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D33CF9DDBD4A8439D8844099EC38E68@softline.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI0LTAzLTA3IGF0IDEwOjU3ICswMTAwLCBKYW4gS2FyY2hlciB3cm90ZToNCg0K
PiBXZSB0aGluayBpdCBtaWdodCBiZSBhbiBvcHRpb24gdG8gc2VjdXJlIHRoZSBwYXRoIGluIHRo
aXMgZnVuY3Rpb24gd2l0aCANCj4gdGhlIHNtYy0+Y2xjc29ja19yZWxlYXNlX2xvY2suDQo+IA0K
PiBgYGANCj4gCWxvY2tfc29jaygmc21jLT5zayk7DQo+IAlpZiAoc21jLT51c2VfZmFsbGJhY2sp
IHsNCj4gCQlpZiAoIXNtYy0+Y2xjc29jaykgew0KPiAJCQlyZWxlYXNlX3NvY2soJnNtYy0+c2sp
Ow0KPiAJCQlyZXR1cm4gLUVCQURGOw0KPiAJCX0NCj4gKwkJbXV0ZXhfbG9jaygmc21jLT5jbGNz
b2NrX3JlbGVhc2VfbG9jayk7DQo+IAkJYW5zdyA9IHNtYy0+Y2xjc29jay0+b3BzLT5pb2N0bChz
bWMtPmNsY3NvY2ssIGNtZCwgYXJnKTsNCj4gKwkJbXV0ZXhfdW5sb2NrKCZzbWMtPmNsY3NvY2tf
cmVsZWFzZV9sb2NrKTsNCj4gCQlyZWxlYXNlX3NvY2soJnNtYy0+c2spOw0KPiAJCXJldHVybiBh
bnN3Ow0KPiAJfQ0KPiBgYGANCj4gDQo+IFdoYXQgZG8geW8gdGhpbmsgYWJvdXQgdGhpcz8NCg0K
WW91J3JlIHRyeWluZyB0byBmaXggaXQgb24gdGhlIHdyb25nIHBhdGguIEZJT0FTWU5DIGlzIGEg
Z2VuZXJpYyByYXRoZXINCnRoYW4gcHJvdG9jb2wtc3BlY2lmaWMgdGhpbmcuIFNvIHVzZXJzcGFj
ZSAnaW9jdGwoc29jaywgRklPQVNZTkMsIFtdKScNCmNhbGwgaXMgaGFuZGxlZCB3aXRoOg0KDQot
PiBzeXNfaW9jdGwoKQ0KICAtPiBkb192ZnNfaW9jdGwoKQ0KICAgIC0+IGlvY3RsX2Zpb2FzeW5j
KCkNCiAgICAgIC0+IGZpbHAtPmZfb3AtPmZhc3luYygpICh3aGljaCBpcyBzb2NrX2Zhc3luYygp
IGZvciBhbGwgc29ja2V0cykNCg0KcmF0aGVyIHRoYW4gJ3NvY2stPm9wcy0+aW9jdGwoLi4uKScu
DQoNCkRtaXRyeQ0KDQo=
