Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34CE2AEE1;
	Fri,  6 Feb 2026 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361280; cv=none; b=at8wLgKDcFyOdvLNGIoR1v951RPazcTQE/hYpTGgJMblU806jCTpjyXsOT10hcmiyTj1FvqWorqPNPnjrHALlYtwuNt0JOQT6UOyHhsoBJeRC79vOv8zHCu24H3HqN3mWOrAPWe9XVDsB38qVHOmYWaOwmJ14LaytuubiAXEfrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361280; c=relaxed/simple;
	bh=DbtTXapqQTPTtzJW5xCgXBR87bBYjgDoDrZkGPsbLCI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=O4/vjFCQfQHuR61itCznXZhyV90yEZpmHpBXXrCLCYmJr+Rc7YGkQguDG3v961P265PwB57qWfriszBL+zaLLkUfhvYpNHGqCMBsnd+seG9T/RR7lIDFxbdhCPD+6+ybxgOcK4NFxwHeQmqIpNQ7r01UgBWTARXY9GfpL9uu13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ukZLubjs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ukZLubjs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s2fXodKFf1ye1tFeAky/3wh+zN/ZlFDJc0/4owEDAy0=; b=ukZLubjsMDlaIReQsEaY6JebDo
	mOaVrorvioXgeNk3YtN7xKtufEQorErtG463K/PgFBTk/8rWlR8Z2be2lxCraVnaIGUbMsb6UpkQf
	tvOeLgsySTQcrEUsWXNlOqC5/0r3r4nmvgWMTIwavAwAUZUQf568YwQ2WkgM0OR6ddcm84DqvMWLT
	NzGCFe1LpF6EuQSPV4H4hIZ69qHtDwYAuL3g071gk2b8pz2CJR4J3V3lBt/4pJU/zN5m9JnNE41aw
	dC7oeiVOrFEKF6STnJXhU2bXtquc2+vClTOa8lU46W6hmVmmbqSfUB00dAQ84WX5Pmhpuj1+smfW1
	p+hSm2Yg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voFq9-0000000Axl6-0H9g;
	Fri, 06 Feb 2026 07:01:17 +0000
Content-Type: multipart/mixed; boundary="------------iTN00Ohr4kyv8a4ypLNH0CPh"
Message-ID: <7f7ffaab-6e66-4c23-970f-752e80080f6f@infradead.org>
Date: Thu, 5 Feb 2026 23:01:14 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net/iucv: clean up iucv kernel-doc warnings
To: Alexandra Winter <wintera@linux.ibm.com>, netdev@vger.kernel.org
Cc: Thorsten Winkler <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20260201072309.222155-1-rdunlap@infradead.org>
 <2ddf6abd-d10c-4d75-8f84-0fd1ccb5435c@linux.ibm.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2ddf6abd-d10c-4d75-8f84-0fd1ccb5435c@linux.ibm.com>

This is a multi-part message in MIME format.
--------------iTN00Ohr4kyv8a4ypLNH0CPh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alexandra,

On 2/2/26 7:35 AM, Alexandra Winter wrote:
> Thank you very much for your effort Randy.
> FYI: I had to use 'scripts/kernel-doc.py -none -Wall include/net/iucv/*' to see the warnings.

I meant to reply to this earlier. Yes, that command certainly works and
I do use it often.

But for testing this patch, I added some (scant) IUCV documentation to the
Documentation/ docbook. The patch that I used it attached.
If you are interested in adding it to the kernel tree, it needs some wordsmithing.

You should see one kernel-doc warning with this patch:
Documentation/networking/iucv:35: ../net/iucv/iucv.c:1918: WARNING: Error in declarator or parameters
Invalid C declaration: Expecting "(" in parameters. [error at 12]
  void __exit iucv_exit (void)
  ------------^

I have sent a kernel-doc patch for that:
  https://lore.kernel.org/linux-doc/20260206065440.2412185-1-rdunlap@infradead.org/T/#u

-- 
~Randy

--------------iTN00Ohr4kyv8a4ypLNH0CPh
Content-Type: text/x-patch; charset=UTF-8; name="docum-iucv-test126.patch"
Content-Disposition: attachment; filename="docum-iucv-test126.patch"
Content-Transfer-Encoding: base64

LS0tCiBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvaW5kZXgucnN0IHwgICAgMSAKIERvY3Vt
ZW50YXRpb24vbmV0d29ya2luZy9pdWN2LnJzdCAgfCAgIDM2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspCgotLS0gbGlu
dXgtbmV4dC0yMDI2MDIwNC5vcmlnL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9pbmRleC5y
c3QKKysrIGxpbnV4LW5leHQtMjAyNjAyMDQvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2lu
ZGV4LnJzdApAQCAtNjksNiArNjksNyBAQCBDb250ZW50czoKICAgIGlwdjYKICAgIGlwdmxh
bgogICAgaXB2cy1zeXNjdGwKKyAgIGl1Y3YKICAgIGtjbQogICAgbDJ0cAogICAgbGFwYi1t
b2R1bGUKLS0tIC9kZXYvbnVsbAorKysgbGludXgtbmV4dC0yMDI2MDIwNC9Eb2N1bWVudGF0
aW9uL25ldHdvcmtpbmcvaXVjdi5yc3QKQEAgLTAsMCArMSwzNiBAQAorLi4gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKKworPT09PT09CitJVUNWCis9PT09PT0KKworT3Zl
cnZpZXcKKz09PT09PT09CisKK0lVQ1YgaXMgdGhlIHovVk0gaW50ZXItdXNlciBjb21tdW5p
Y2F0aW9ucyB2ZWhpY2xlLiBJdCBpcyB1c2VkIGZvcgorZm9yIHovVk0gaW50ZXItdXNlciBj
b21tdW5pY2F0aW9uIG9yIHdpdGggdGhlIHovVk0gSFZDIChoeXBlcnZpc29yCitjb25zb2xl
KSBkcml2ZXIuCitJdCBjYW4gYWxzbyBiZSB1c2VkIHRvIGFzc2lzdCB3aXRoIGEgei9WTSBN
T05JVE9SIGFwcGxpY2F0aW9uLgorKFNlZSBEb2N1bWVudGF0aW9uL2FyY2gvczM5MC9tb25y
ZWFkZXIucnN0KQorCisKK0ltcGxlbWVudGF0aW9uCis9PT09PT09PT09PT09PQorCitUaGUg
SVVDViBpbnRlcmZhY2VzIGFyZSBkb2N1bWVudGVkIGluIGl1Y3YuaCBhbmQgaXVjdi5jLgor
CisKK0V4cG9ydGVkIGludGVyZmFjZXMKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
KworLi4ga2VybmVsLWRvYzo6IGluY2x1ZGUvbmV0L2l1Y3YvaXVjdi5oCisgICA6aW50ZXJu
YWw6CisKKy4uIGtlcm5lbC1kb2M6OiBuZXQvaXVjdi9pdWN2LmMKKyAgIDpleHBvcnQ6CisK
K0ludGVybmFsIGludGVyZmFjZXMKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQorCisuLiBrZXJu
ZWwtZG9jOjogbmV0L2l1Y3YvaXVjdi5jCisgICA6aW50ZXJuYWw6Cg==

--------------iTN00Ohr4kyv8a4ypLNH0CPh--
