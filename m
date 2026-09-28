Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4867C38F624
	for <linux-s390@vger.kernel.org>; Mon, 28 Sep 2026 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576655; cv=none; b=GZwDbAkmDRS3nri1EMeXhSk1k/fSXchjqNfVRgjoQ6Vd9s5OrYi38C93/IG2S6/XwtSc10K0dEOFZDUY3Y9eBYCsCRW3UFOl8rIzS7t9mDjWF+tOjDATs22QzbFNafEHGuViW5caWfDwXuC1xRngOVhcw7v3i+4rdhnBIwbyuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576655; c=relaxed/simple;
	bh=Fuhci/NNQLVUzWkpUJ9YcTdRVY+06L73ZSAsWbc+3VE=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IA5b86aJPrb4DqoKSrIXdAMhXPaZ7USfU7XkzcGQVo1unARSpJesx3u+ekpYtMkK3/obu3unQN7ngTHIJ8tYIyEf8Z9/7ERu+cWqFaS6RPd48pHuhznJwzKptIBB7ragpeSDA1TfCCZWlNe6N7uoxv9GlKbahnvuA4/IDpJliVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwhbLYPl; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwhbLYPl"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8a45b788a71so18801647b3.0
        for <linux-s390@vger.kernel.org>; Sun, 27 Sep 2026 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790576653; x=1791181453; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NgBUoAGMce0wDtJT/5tr5PejNWm/4KbKs95+kgenKk4=;
        b=lwhbLYPl64zWjoPjXWDqJSw4cdTJLhD/Nr/crQNjqiUD6XiCKfFeTIPvEXhCdZ0mre
         mFBx0rU9DBt9ioC07p3a9hsTI4CbrD1o+oAXQiTL2WspaDVX27vTfnFdTdRCtaT+hA+u
         4lk9nCkNZPgrCwFoZOAdsOLXea/Cb+gAyZyc9lyLJHQTS2AVEMwrIEwFvyIVY0flVUeR
         teo7bwE/oHbL/oENB1lSYFqVTHn9xRoNpUUVwemul0zUkBOyjr8Q/z7XixeaGOaGvXGe
         RY40FAhjeVnE6U2urvMol5gubOXBNwfLCGnIdB3AZfzM8qrol1haTXmuJplIAOW0CpGD
         w7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576653; x=1791181453;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgBUoAGMce0wDtJT/5tr5PejNWm/4KbKs95+kgenKk4=;
        b=fgUkcmy473r40vDUlrbp7YlDVcuYiDbCDGIPuj0Kh1ptwuRAGILewusInQ6qf/T5dH
         DoqWhbgE2acbQrzhqgiYQAox/tP1+MvJgVjokUzVBj1ultAC7awGjzFAMI8T3oDxxD7F
         bgvwfN1jUfkQ2gfLcAVN4wTxVWyOPIt0KCfHwOAwOBb4jWriuv4NYjAkz1qChdzLnTaw
         q2zz3MJwVZdRqPuLaeGb0yBlm/snXrduHKjT7rvbamB1/5yo1dUNWCsRpxxPmvJPy2vZ
         +4ulJPqFDKxfOCVRJXxhnobbxqFzE0RFbuKXzYTVgblmR0w0KOhKmDSx34g0eE7p9GDE
         O/4A==
X-Forwarded-Encrypted: i=1; AKwUvBzxwsc2JKgGDszeingdGaw0cBecd2xzeddDS2ys4eBcDjrKFWd8DXb0ODLGLg4Etnrx2+JFra9cRMGl@vger.kernel.org
X-Gm-Message-State: AFq9FYKfKpDOQDsiGcz/hXA8ZuCYsz0iMqQ4ttXW2qCpuuGJ23sR8bgj
	auxndNBkYRKmtl9ssjl9t+9gPPQXc0M1kSaMTKFtqj4eBRJKk1TqML7C
X-Gm-Gg: AYBFou0ojEkX7uKyH8JU7Sz3xuvW7QJDUgQnhooJbSHBup9em1hI8C+adOcABxNfths
	rSGNj8uFZFTYORDm6Id8Tj919rlm7du6u68zG3nCny3T+0e3O7aB7TBSjynfqbd72H6fQ4e5H3T
	GwBFzRJ9yBP4XWoCvfKm3KQbHQosWOsEYLKz+/Z9xE6LtwJfcoDhYTAkEu1++hz9Z68VCWIvzj3
	Put/PZCmDAtV0KEjYXIUvKIC+pF4VwMXw2RnEbY/5rT0ks6q0PiuQ0lqHp58aIGrQzsRHAjQg2g
	f2vlWZoPnm6gu7XFbyhi9RWBJFMViVGzPGlc4bL4FBTj5t+UZkOKtQGwR+Rx1K/xUTFIAuKlUtc
	Tpsu+oKUxWyHdb19S61WT5sHjXtE2bRTVV8Y2r3b6oVpTNFPI23f+3B4mrCVyv+Ap/1+CKryKhn
	YlqJI/8kaXooa2GHn/s0CzC6W2mqiBGEnVzQ2Wn+Q6rfego6o4MsKjcpyBTXJXAZ4FqmkiXCD4G
	bB2Lq+AErLlFBWgLMqZLmF+tdKPNXhFnB7SOsoXByaaJ9ynELNWxW0ZQoq6sQQ78HusSzMwLbzy
	gqJEOXDrc8IJ6gIB9dHZY3sAbeuFgXUqk+ILi4T5kGld7tIZvatZN908ayurX2LmBnZurcalWlo
	wZ5IjCx9pymxh/sX5vgE2WjIbtf4eStgm6YYXQ4YBtQcNF+9kx73z67Nwd5FwNLGl+CSGh7CYJ0
	PnmnZdMnhJIYTkxshMgZ9acbE9RG2dp18NoBdB
X-Received: by 2002:a05:690e:803:20b0:675:47ba:21b3 with SMTP id 956f58d0204a3-67547ba2609mr574124d50.103.1790576653226;
        Sun, 27 Sep 2026 23:24:13 -0700 (PDT)
Received: from [10.0.0.19] (c-73-137-217-102.hsd1.ga.comcast.net. [73.137.217.102])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a86108f052sm39434077b3.49.2026.09.27.23.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:24:12 -0700 (PDT)
Message-ID: <6aba080c.b933486d.297b72.5042@mx.google.com>
Date: Sun, 27 Sep 2026 23:24:12 -0700 (PDT)
From: Atharva Vartak <atharva.a.vartak@gmail.com>
To: security@kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 mjambigi@linux.ibm.com, sidraya@linux.ibm.com, w@1wt.eu,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] net/smc: hold a reference on net_device returned by
 pnet_find_base_ndev()
In-Reply-To: <arn3qTu_SeM8Yrjj@1wt.eu>
References: <arn3qTu_SeM8Yrjj@1wt.eu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

pnet_find_base_ndev() resolves the base net_device for stacked devices
under RTNL, then drops the lock and returns the raw pointer without
taking a reference.  All three callers dereference the pointer after
RTNL has been released, creating a use-after-free window if the device
is concurrently unregistered.

Take dev_hold() before dropping RTNL and add the matching dev_put() in
every return path of the three callers:

  - smc_pnet_add_eth()
  - smc_pnet_find_roce_by_pnetid()
  - smc_pnet_find_ism_by_pnetid()

Fixes: 0afff91c6f5e ("net/smc: add pnetid support")
Fixes: 1619f770589a ("net/smc: add pnetid support for SMC-D and ISM")
Cc: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Dust Li <dust.li@linux.alibaba.com>
Cc: Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>
Cc: Wen Gu <guwen@linux.alibaba.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: linux-rdma@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Atharva Vartak <atharva.a.vartak@gmail.com>
---
Apologies for not Cc'ing the maintainers on the initial report, will
follow the process properly going forward.

Based on v7.3-rc5. Passes checkpatch and compiles cleanly.

 net/smc/smc_pnet.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index ff9c9c35c..d6e2f4454 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -367,8 +367,11 @@ static int smc_pnet_add_eth(struct smc_pnettable *pnetta=
ble, struct net *net,
 	if (ndev) {
 		base_ndev =3D pnet_find_base_ndev(ndev);
 		if (!smc_pnetid_by_dev_port(base_ndev->dev.parent,
-					    base_ndev->dev_port, ndev_pnetid))
+					    base_ndev->dev_port, ndev_pnetid)) {
+			dev_put(base_ndev);
 			goto out_put;
+		}
+		dev_put(base_ndev);
 	}
=20
 	/* add a new netdev entry to the pnet table if there isn't one */
@@ -949,6 +952,8 @@ static struct net_device *pnet_find_base_ndev(struct net_=
device *ndev)
 {
 	rtnl_lock();
 	ndev =3D __pnet_find_base_ndev(ndev);
+	/* keep ndev alive after dropping RTNL, callers must dev_put() */
+	dev_hold(ndev);
 	rtnl_unlock();
 	return ndev;
 }
@@ -1094,8 +1099,10 @@ static void smc_pnet_find_roce_by_pnetid(struct net_de=
vice *ndev,
 	    smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid) &&
 	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
 		smc_pnet_find_rdma_dev(base_ndev, ini);
+		dev_put(base_ndev);
 		return; /* pnetid could not be determined */
 	}
+	dev_put(base_ndev);
 	_smc_pnet_find_roce_by_pnetid(ndev_pnetid, ini, NULL, net);
 }
=20
@@ -1108,8 +1115,10 @@ static void smc_pnet_find_ism_by_pnetid(struct net_dev=
ice *ndev,
 	ndev =3D pnet_find_base_ndev(ndev);
 	if (smc_pnetid_by_dev_port(ndev->dev.parent, ndev->dev_port,
 				   ndev_pnetid) &&
-	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid))
+	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
+		dev_put(ndev);
 		return; /* pnetid could not be determined */
+	}
=20
 	mutex_lock(&smcd_dev_list.mutex);
 	list_for_each_entry(ismdev, &smcd_dev_list.list, list) {
@@ -1123,6 +1132,7 @@ static void smc_pnet_find_ism_by_pnetid(struct net_devi=
ce *ndev,
 		}
 	}
 	mutex_unlock(&smcd_dev_list.mutex);
+	dev_put(ndev);
 }
=20
 /* PNET table analysis for a given sock:
--=20
2.54.0

