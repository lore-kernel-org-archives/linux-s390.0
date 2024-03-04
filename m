Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B88E4D5A6;
	Mon,  4 Mar 2024 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570522; cv=none; b=lavultvP52ML3GjAgHbvL8PS4WX133c/T1jxXhR2gAlEXAxxpC2xJQXXViTTVjidMVlTweSz3kzL1ni3e3VtpJRnRw7Kah7knr15MKggTklsyAwrHKoZVRY57krjYBI8+UGobvfwYvEw6FR9grnU1N+RmxdsX2c+QLlMWsjhP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570522; c=relaxed/simple;
	bh=hk7+v+aeqrRZnGbW7ZHLgyqEFN+ZiTFPpDnpQFgPyK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6zw4sSfnEx/Z6/OKKpGxNF35ogDgTQItTwHU5jb1ggujjDlLpPwP8lQ/8/cDGrdiznOpulJj8T50t6EHoh2yjrZ8rRQb/W8ZuqasXm9c5YGKRh7QNScY4waBluk5rmmxDwESrt0fEhTf4cncNU3CckF0H/niwV9o8SivNfYrPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=LvE/ACSw; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="LvE/ACSw"
Received: from mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1302:0:640:9f1e:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 3337F61278;
	Mon,  4 Mar 2024 19:35:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4Zh89nSOcqM0-1r4u4fMs;
	Mon, 04 Mar 2024 19:35:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1709570105; bh=hk7+v+aeqrRZnGbW7ZHLgyqEFN+ZiTFPpDnpQFgPyK4=;
	h=In-Reply-To:To:From:Cc:Date:References:Subject:Message-ID;
	b=LvE/ACSwVncuDXhH92NpKubKPNW5iocUFN/YVnE0Jttm35dlzvOIZAaBd5dp7aqa0
	 ksy64deg/v6Tnu7OIfhPiANd+D/Ms3zUWEK0XO77mcngoqpFYzgEG5oaPqK/avaCQo
	 1qehlqrmvCHOGA31qinvuDpN+1XqQwc32JIAT8m8=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <380043fa-3208-4856-92b1-be9c87caeeb6@yandex.ru>
Date: Mon, 4 Mar 2024 19:35:04 +0300
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [lvc-project] [PATCH] [RFC] net: smc: fix fasync leak in
 smc_release()
To: Wen Gu <guwen@linux.alibaba.com>,
 "wenjia@linux.ibm.com" <wenjia@linux.ibm.com>
Cc: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jaka@linux.ibm.com" <jaka@linux.ibm.com>
References: <20240221051608.43241-1-dmantipov@yandex.ru>
 <819353f3-f5f9-4a15-96a1-4f3a7fd6b33e@linux.alibaba.com>
 <659c7821842fca97513624b713ced72ab970cdfc.camel@softline.com>
 <19d7d71b-c911-45cc-9671-235d98720be6@linux.alibaba.com>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 xsDNBGBYjL8BDAC1iFIjCNMSvYkyi04ln+5sTl5TCU9O5Ot/kaKKCstLq3TZ1zwsyeqF7S/q
 vBVSmkWHQaj80BlT/1m7BnFECMNV0M72+cTGfrX8edesMSzv/id+M+oe0adUeA07bBc2Rq2V
 YD88b1WgIkACQZVFCo+y7zXY64cZnf+NnI3jCPRfCKOFVwtj4OfkGZfcDAVAtxZCaksBpTHA
 tf24ay2PmV6q/QN+3IS9ZbHBs6maC1BQe6clFmpGMTvINJ032oN0Lm5ZkpNN+Xcp9393W34y
 v3aYT/OuT9eCbOxmjgMcXuERCMok72uqdhM8zkZlV85LRdW/Vy99u9gnu8Bm9UZrKTL94erm
 0A9LSI/6BLa1Qzvgwkyd2h1r6f2MVmy71/csplvaDTAqlF/4iA4TS0icC0iXDyD+Oh3EfvgP
 iEc0OAnNps/SrDWUdZbJpLtxDrSl/jXEvFW7KkW5nfYoXzjfrdb89/m7o1HozGr1ArnsMhQC
 Uo/HlX4pPHWqEAFKJ5HEa/0AEQEAAc0kRG1pdHJ5IEFudGlwb3YgPGRtYW50aXBvdkB5YW5k
 ZXgucnU+wsEPBBMBCAA5FiEEgi6CDXNWvLfa6d7RtgcLSrzur7cFAmBYjL8FCQWjmoACGwMF
 CwkIBwIGFQgJCgsCBRYCAwEAAAoJELYHC0q87q+34CEMAKvYwHwegsKYeQokLHXeJVg/bcx9
 gVBPj88G+hcI0+3VBdsEU0M521T4zKfS6i7FYWT+mLgf35wtj/kR4akAzU3VyucUqP92t0+T
 GTvzNiJXbb4a7uxpSvV/vExfPRG/iEKxzdnNiebSe2yS4UkxsVdwXRyH5uE0mqZbDX6Muzk8
 O6h2jfzqfLSePNsxq+Sapa7CHiSQJkRiMXOHZJfXq6D+qpvnyh92hqBmrwDYZvNPmdVRIw3f
 mRFSKqSBq5J3pCKoEvAvJ6b0oyoVEwq7PoPgslJXwiuBzYhpubvSwPkdYD32Jk9CzKEF9z26
 dPSVA9l8YJ4o023lU3tTKhSOWaZy2xwE5rYHCnBs5sSshjTYNiXflYf8pjWPbQ5So0lqxfJg
 0FlMx2S8cWC7IPjfipKGof7W1DlXl1fVPs6UwCvBGkjUoSgstSZd/OcB/qIcouTmz0Pcd/jD
 nIFNw/ImUziCdCPRd8RNAddH/Fmx8R2h/DwipNp1DGY251gIJQVO3c7AzQRgWIzAAQwAyZj1
 4kk+OmXzTpV9tkUqDGDseykicFMrEE9JTdSO7fiEE4Al86IPhITKRCrjsBdQ5QnmYXcnr3/9
 i2RFI0Q7Evp0gD242jAJYgnCMXQXvWdfC55HyppWazwybDiyufW/CV3gmiiiJtUj3d8r8q6l
 aXMOGky37sRlv1UvjGyjwOxY6hBpB2oXdbpssqFOAgEw66zL54pazMOQ6g1fWmvQhUh0TpKj
 JZRGF/sib/ifBFHA/RQfAlP/jCsgnX57EOP3ALNwQqdsd5Nm1vxPqDOtKgo7e0qx3sNyk05F
 FR+f9px6eDbjE3dYfsicZd+aUOpa35EuOPXS0MC4b8SnTB6OW+pmEu/wNzWJ0vvvxX8afgPg
 lUQELheY+/bH25DnwBnWdlp45DZlz/LdancQdiRuCU77hC4fnntk2aClJh7L9Mh4J3QpBp3d
 h+vHyESFdWo5idUSNmWoPwLSYQ/evKynzeODU/afzOrDnUBEyyyPTknDxvBQZLv0q3vT0Uiq
 caL7ABEBAAHCwPwEGAEIACYWIQSCLoINc1a8t9rp3tG2BwtKvO6vtwUCYFiMwAUJBaOagAIb
 DAAKCRC2BwtKvO6vtwe/C/40zBwVFhiQTVJ5v9heTiIwfE68ZIKVnr+tq6+/z/wrRGNro4PZ
 fnqumrZtC+nD2Aj5ktNmrwlL2gTauhMT/L0tUrr287D4AHnXfZJT9fra+1NozFm7OeYkcgxh
 EG2TElxcnXSanQffA7Xx25423FD0dkh2Z5omMqH7cvmh45hBAO/6o9VltTe9T5/6mAqUjIaY
 05v2npSKsXqavaiLt4MDutgkhFCfE5PTHWEQAjnXNd0UQeBqR7/JWS55KtwsFcPvyHblW4be
 9urNPdoikGY+vF+LtIbXBgwK0qp03ivp7Ye1NcoI4n4PkGusOCD4jrzwmD18o0b31JNd2JAB
 hETgYXDi/9rBHry1xGnjzuEBalpEiTAehORU2bOVje0FBQ8Pz1C/lhyVW/wrHlW7uNqNGuop
 Pj5JUAPxMu1UKx+0KQn6HYa0bfGqstmF+d6Stj3W5VAN5J9e80MHqxg8XuXirm/6dH/mm4xc
 tx98MCutXbJWn55RtnVKbpIiMfBrcB8=
In-Reply-To: <19d7d71b-c911-45cc-9671-235d98720be6@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMi8yMy8yNCAwNjozNiwgV2VuIEd1IHdyb3RlOg0KDQo+IE9uZSBzb2x1dGlvbiB0byB0
aGlzIGlzc3VlIEkgY2FuIHRoaW5rIG9mIGlzIHRvIGNoZWNrIHdoZXRoZXINCj4gZmlscC0+
cHJpdmF0ZV9kYXRhIGhhcyBiZWVuIGNoYW5nZWQgd2hlbiB0aGUgc29ja19mYXN5bmMgaG9s
ZHMgdGhlIHNvY2sgbG9jaywNCj4gYnV0IGl0IGluZXZpdGFibHkgY2hhbmdlcyB0aGUgZ2Vu
ZXJhbCBjb2RlLi4NCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvc29ja2V0LmMgYi9uZXQvc29j
a2V0LmMNCj4gaW5kZXggZWQzZGYyZjc0OWJmLi5hMjg0MzUxOTU4NTQgMTAwNjQ0DQo+IC0t
LSBhL25ldC9zb2NrZXQuYw0KPiArKysgYi9uZXQvc29ja2V0LmMNCj4gQEAgLTE0NDMsNiAr
MTQ0MywxMSBAQCBzdGF0aWMgaW50IHNvY2tfZmFzeW5jKGludCBmZCwgc3RydWN0IGZpbGUg
KmZpbHAsIGludCBvbikNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gLUVJTlZBTDsNCj4gDQo+ICDCoMKgwqDCoMKgwqDCoCBsb2NrX3NvY2soc2spOw0KPiAr
wqDCoMKgwqDCoMKgIC8qIGZpbHAtPnByaXZhdGVfZGF0YSBoYXMgY2hhbmdlZCAqLw0KPiAr
wqDCoMKgwqDCoMKgIGlmIChvbiAmJiB1bmxpa2VseShzb2NrICE9IGZpbHAtPnByaXZhdGVf
ZGF0YSkpIHsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVsZWFzZV9zb2Nr
KHNrKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FQUdBSU47
DQo+ICvCoMKgwqDCoMKgwqAgfQ0KPiAgwqDCoMKgwqDCoMKgwqAgZmFzeW5jX2hlbHBlcihm
ZCwgZmlscCwgb24sICZ3cS0+ZmFzeW5jX2xpc3QpOw0KPiANCj4gIMKgwqDCoMKgwqDCoMKg
IGlmICghd3EtPmZhc3luY19saXN0KQ0KPiANCj4gTGV0J3Mgc2VlIGlmIGFueW9uZSBlbHNl
IGhhcyBhIGJldHRlciBpZGVhLg0KDQpJSVVDIHRoaXMgaXMgbm90IGEgc29sdXRpb24ganVz
dCBiZWNhdXNlIGl0IGRlY3JlYXNlcyB0aGUgcHJvYmFiaWxpdHkgb2YgdGhlIHJhY2UNCmJ1
dCBkb2Vzbid0IGVsaW1pbmF0ZSBpdCBjb21wbGV0ZWx5IC0gYW4gdW5kZXJseWluZyBzb2Nr
ZXQgc3dpdGNoIChlLmcuIGNoYW5naW5nDQonZmlscC0+cHJpdmF0ZV9kYXRhJykgbWF5IGhh
cHBlbiB3aGVuICdmYXN5bmNfaGVscGVyKCknIGlzIGluIHByb2dyZXNzLg0KDQpEbWl0cnkN
Cg0KDQo=
