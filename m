Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193045;
	b=iE6HMxttMXSs6fOMNzfCbKxTIDae069XSXDz+EuDyTlEqw+2Wx1NfGLbeSYFfdEMA6GV
	 tfX+komZrU4ATA1EWNszZ+qiW5Obw4CZ9YKpskWoN8GP3kOzX+Di1HyBqNtyPYFUc3sLE
	 NcZDw8nAiC2s7xbGWLcTntHv4snNVCz6EakiduISFo/lTSy5pg0jr3UGNRz/ws91jmzWS
	 Sg2UGGz7nHbBFrpuOIH1wFShtECzhxPOqyJrsr7mdP34VuEQo736MuOHRP0HbAO+xPx7x
	 K78dB2+vVRbzTXTDd+dU3hTCIeHc9Amv65kr1EqEnB/at/PphpZ3RuTNJ4SuODk27qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193045;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=slSez8APteyrjAQFVPi36IPS8gsYJrd9o7OEPdbfuX0=;
	b=AuqwRwraZ0j8+0ChEOcf4DiZyUYROf/hCJ0QjgKnqb1JYGcVD81xSfTJ73tUTSDsF9cT
	 eVbRvt4FMkkdc5QDkiEzhrlEi9I9dJFxiZIxx+qoh5Y//sscDoqBlO5gKFhTroTNWhhcU
	 hemvQm8bpJhpM0xojjxf4Z+VFCrfS+PvqI5vyu985smSU7uT+V+J3iX2en3cSOZ5kDnj9
	 v/c+/5604jHL8viLUUiSCVEwuY/M13tqdglwrqLYuvUKavC9igVJToZEAYjwpt/vgx95g
	 A/Gj9fY0ToztcrfqhhaWPN0uCKll9wiR9PbVxc9P4gYPpAZn5iqQeDmHilHCq52M3ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UVo4mFcv;
	arc=none smtp.remote-ip=95.215.58.65
Received: from mta1.migadu.com (out-65.mta1.migadu.com [95.215.58.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD12606A331
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 02:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBD12606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UVo4mFcv
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3ZW9WdZ2Gaii+5kPjGa0iMjjl+g4WUyJikDdM5XjZ10=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794193042; v=1; x=1794797842;
 b=UVo4mFcv9Q4H2cIE2qz310LcnD++QCHbOylIue1Vs0G6jgrLPp+xVvhGyNgSeXOl0pvzHqg3
 4fg7KzseuvrVEmjug3M7XgifnRXdeQ6dywNlzXN2u4Lvyv6LkO3SrcfLrs+JsCsbOeVx0MpIa2W
 gfPb8wsrXh3AUd5fkgs3vTKc=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e7634fc4ade2e7d9;
	Mon, 09 Nov 2026 02:57:22 +0000
X-Mizu-Trace-ID: e7634fc4ade2e7d9
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Paul Moore <paul@paul-moore.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Julian Anastasov <ja@ssi.bg>,
	Allison Henderson <achender@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	mptcp@lists.linux.dev,
	lvs-devel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-sctp@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next 05/14] calipso: annotate data-races around cache sysctls
Date: Mon,  9 Nov 2026 10:52:04 +0800
Message-ID: <20261109025425.328445-6-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109025425.328445-1-jiayuan.chen@linux.dev>
References: <20261109025425.328445-1-jiayuan.chen@linux.dev>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

calipso_cache_enabled and calipso_cache_bucketsize are read without any
lock while their sysctl handlers update them with WRITE_ONCE(). Add
READ_ONCE() to the readers.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/calipso.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index e399a42e30839..5e63212b60163 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -204,7 +204,7 @@ static int calipso_cache_check(const unsigned char *key,
 	struct calipso_map_cache_entry *prev_entry = NULL;
 	u32 hash;
 
-	if (!calipso_cache_enabled)
+	if (!READ_ONCE(calipso_cache_enabled))
 		return -ENOENT;
 
 	hash = calipso_map_cache_hash(key, key_len);
@@ -269,7 +269,7 @@ static int calipso_cache_add(const unsigned char *calipso_ptr,
 	struct calipso_map_cache_entry *old_entry = NULL;
 	u32 calipso_ptr_len;
 
-	if (!calipso_cache_enabled || calipso_cache_bucketsize <= 0)
+	if (!READ_ONCE(calipso_cache_enabled) || READ_ONCE(calipso_cache_bucketsize) <= 0)
 		return 0;
 
 	calipso_ptr_len = calipso_ptr[1];
@@ -289,7 +289,7 @@ static int calipso_cache_add(const unsigned char *calipso_ptr,
 
 	bkt = entry->hash & (CALIPSO_CACHE_BUCKETS - 1);
 	spin_lock_bh(&calipso_cache[bkt].lock);
-	if (calipso_cache[bkt].size < calipso_cache_bucketsize) {
+	if (calipso_cache[bkt].size < READ_ONCE(calipso_cache_bucketsize)) {
 		list_add(&entry->list, &calipso_cache[bkt].list);
 		calipso_cache[bkt].size += 1;
 	} else {
-- 
2.43.0

