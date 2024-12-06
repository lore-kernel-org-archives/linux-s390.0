Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1393D47F53
	for <linux-s390@vger.kernel.org>; Fri,  6 Dec 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496504; cv=none; b=clFpCFMHHhJHbO0+cgCnP2L9PMjaE+2sE3Hztm0e22lv8dq03nssXaUtlmAnUKG9V/Bc2s/5xYsHMMQMkHucLJn+JfcqB4mZCwf680q5yRwDhla20zHvZcDXjuCFpC1CnTRZoUpoxcNYJZ+zN24vjz0LwL105P8y2D2tEf7vAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496504; c=relaxed/simple;
	bh=a4VdDgcNRQispJAYUjxPoAHZ3vxUxA88remkA5pmB+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=mNQgwCWbqFuq3wLgg6u8Cucl2JT4Its43ZIBgriQzdrKT5nuiUsF5cM++moKsUExW1RqQhdcPgpgmq/nwoWIBQy/VmiXM1uSwLrqvTc39zw8Ychu1KIfX9Sg20BbdhfzBStOopwwfc/y1/uC6xBZeeDZ0kqeqhsyqFO1g/znCRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-287-azdpdCQEMWK4TCHGYV3GAg-1; Fri, 06 Dec 2024 14:48:19 +0000
X-MC-Unique: azdpdCQEMWK4TCHGYV3GAg-1
X-Mimecast-MFC-AGG-ID: azdpdCQEMWK4TCHGYV3GAg
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 6 Dec
 2024 14:47:33 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 6 Dec 2024 14:47:33 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>, Alexandra Winter
	<wintera@linux.ibm.com>
CC: Rahul Rameshbabu <rrameshbabu@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, David Miller <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Nils Hoppmann <niho@linux.ibm.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Thorsten Winkler
	<twinkler@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
Thread-Topic: [PATCH net-next] net/mlx5e: Transmit small messages in linear
 skb
Thread-Index: AQHbRlnOqxcJ6RUXVkmlcnxPCu2657LZSr5g
Date: Fri, 6 Dec 2024 14:47:32 +0000
Message-ID: <138dab5cc2ee40229a72804c2b92dce3@AcuMS.aculab.com>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <CANn89i+DX-b4PM4R2uqtcPmztCxe_Onp7Vk+uHU4E6eW1H+=zA@mail.gmail.com>
 <CANn89iJZfKntPrZdC=oc0_8j89a7was90+6Fh=fCf4hR7LZYSQ@mail.gmail.com>
In-Reply-To: <CANn89iJZfKntPrZdC=oc0_8j89a7was90+6Fh=fCf4hR7LZYSQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: od4qOcLWd5F21Ie6am7ke9NyngP8qbZSv-yzQSvFf9M_1733496498
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDA0IERlY2VtYmVyIDIwMjQgMTQ6MzYNCi4uLg0K
PiBJIHdvdWxkIHN1Z2dlc3QgdGhlIG9wcG9zaXRlIDogY29weSB0aGUgaGVhZGVycyAodHlwaWNh
bGx5IGxlc3MgdGhhbg0KPiAxMjggYnl0ZXMpIG9uIGEgcGllY2Ugb2YgY29oZXJlbnQgbWVtb3J5
Lg0KDQpBIGxvbmcgdGltZSBhZ28gYSBjb2xsZWFndWUgdGVzdGVkIHRoZSBjdXRvZmYgYmV0d2Vl
biBjb3B5aW5nIHRvDQphIGZpeGVkIGJ1ZmZlciBhbmQgZG1hIGFjY2VzcyB0byB0aGUga2VybmVs
IG1lbW9yeSBidWZmZXIgZm9yDQphIHNwYXJjIG1idXMvc2J1cyBzeXN0ZW0gKHdoaWNoIGhhcyBh
biBpb21tdSkuDQpXaGlsZSBlbnRpcmVseSBkaWZmZXJlbnQgaW4gYWxsIHJlZ2FyZHMgdGhlIGN1
dG9mZiB3YXMganVzdCBvdmVyIDFrLg0KDQpUaGUgZXRoZXJuZXQgZHJpdmVycyBJIHdyb3RlIGRp
ZCBhIGRhdGEgY29weSB0by9mcm9tIGEgcHJlLW1hcHBlZA0KYXJlYSBmb3IgYm90aCB0cmFuc21p
dCBhbmQgcmVjZWl2ZS4NCkkgc3VzcGVjdCB0aGUgc2ltcGxpY2l0eSBvZiB0aGF0IGFsc28gaW1w
cm92ZWQgdGhpbmdzLg0KDQpUaGVzZSBkYXlzIHlvdSdkIGRlZmluaXRlbHkgd2FudCB0byBtYXAg
dHNvIGJ1ZmZlcnMuDQpCdXQgdGhlICdjb3B5YnJlYWsnIHNpemUgZm9yIHJlY2VpdmUgY291bGQg
YmUgcXVpdGUgaGlnaC4NCg0KT24geDg2IGp1c3QgbWFrZSBzdXJlIHRoZSBkZXN0aW5hdGlvbiBh
ZGRyZXNzIGZvciAncmVwIG1vdnNiJw0KaXMgNjQgYnl0ZSBhbGlnbmVkIC0gaXQgd2lsbCBkb3Vi
bGUgdGhlIGNvcHkgc3BlZWQuDQpUaGUgc291cmNlIGFsaWdubWVudCBkb2Vzbid0IG1hdHRlciBh
dCBhbGwuDQooQU1EIGNoaXBzIG1pZ2h0IGJlIGRpZmZlcmVudCwgYnV0IGFuIGFsaWduZWQgY29w
eSBvZiBhIHdob2xlDQpudW1iZXIgb2YgJ3dvcmRzJyBjYW4gYWx3YXlzIGJlIGRvbmUuKQ0KDQpJ
J3ZlIGFsc28gd29uZGVyZWQgd2hldGhlciB0aGUgZXRoZXJuZXQgZHJpdmVyIGNvdWxkICdob2xk
JyB0aGUNCmlvbW11IHBhZ2UgdGFibGUgZW50cmllcyBhZnRlciAoZWcpIGEgcmVjZWl2ZSBmcmFt
ZSBpcyBwcm9jZXNzZWQNCmFuZCB0aGVuIGRyb3AgdGhlIFBBIG9mIHRoZSByZXBsYWNlbWVudCBi
dWZmZXIgaW50byB0aGUgc2FtZSBzbG90Lg0KVGhhdCBpcyBsaWtlbHkgdG8gc3BlZWQgdXAgaW9t
bXUgc2V0dXAuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

