Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173101;
	b=TY5Si0bsVnhNBaLHZqaf5imi5PEIlKRkMpRDSfoHSTSUgzlYzvgOtLlRa5vf9R1RfzLU
	 LCJUqDwLrrpsu2qM7ipYIH285HmrtTsjVDVMV8zT9AReRdp1NMEMUnCHH8gsphA2xD+qy
	 RsuAUyzqfxg9xvIZ8PUiDbWgFBAZ4VTmQk4E25FiYCnzSsg66MuLGqCPUEBbtPtYZ7kWs
	 A97xifT2tHZFNtzlMsu/2Lj2IPcmJUPnyDFHtnHH6uIz/RcQdsLFkNu4NFPZN6HGEBI/C
	 58WR/bIaJRZnxoNTlBDczVPh/afsPo60nQnPHMGcutED6IEYhGju6XaQUnBCWtGVMdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=cJsM+MQDScvHYXZpHmUi9y/qw9WP8MQjdcWo+D8X4wU=;
	b=H2jGqe4NFzv7K5iBPHS/QZD3lcfKkfTKzX0NdtkQI35cLO7a5ruePrKujFEhAaeVFkyn
	 fDXJstRAKvdsTFZMl2cucyZK334VwWZtUBlEasywkqgGO2B5jtcScInG4EdFn5eY7z/y4
	 QntLohtLTzYdxlLJ0qBGFcRWX5xMNNojGbEDGsN3lry0mDra5vXJfG8xbfSJQ5ZmFPasZ
	 bZmURRSumER2adP8zk20yaTkltEO4LCNugzIvtmc/8oWCcnR9qGxoOI/h2oX1IdIAAsiZ
	 PwL2DFAykiiSxe8zNI2UDGJRtCHj6qWb9Y72NZx6ZN/CsvQtx6dXqBR6feufOcv9s0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CnCAGgbb;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BDA60A5BC6
	for <linux-s390@vger.kernel.org>; Fri, 20 Nov 2026 11:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3BDA60A5BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CnCAGgbb
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4a34ffd3e39so395698f8f.0
        for <linux-s390@vger.kernel.org>; Fri, 20 Nov 2026 03:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795173099; x=1795777899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cJsM+MQDScvHYXZpHmUi9y/qw9WP8MQjdcWo+D8X4wU=;
        b=CnCAGgbbEqFA9jzaANJ+NwiS72MZwGiwPVI4mGe4oZS+cFWLanYLm5knHTkil4TNaX
         dpstToWTnnhWXhEy94X+q90MyF04FWEvSWyZWsK4C+Pk5W0+kG3//tIAxH7gS6v/XlNm
         DxvIL3LPq+fD02ayh2h+6FXDDFttLt8NtUX/T3wHysmyfXrxh7eiNv+J8pfWiGI/c1Qz
         TehOsuEtSNgvf+rzhq67zS5UQqc3D3HtOSlufRXLYvhv6/VTsgH7aQmyWOq6Pd92/gVL
         sLpC/6lGIPGLpy9Z1i7WI/LnujNOtMr3cHvsfKRNMgjsUVHYqhT4HRJpvD6w5UW+IaX5
         1hCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173099; x=1795777899;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cJsM+MQDScvHYXZpHmUi9y/qw9WP8MQjdcWo+D8X4wU=;
        b=UpzyTinpg+vJPHIzzc7hXPMUuTrSyDa3mRQAt4+cGjKDa234SCSKXXOuyr4N/4Llk6
         jWlJvgQJ9D2gN5JE4CMbx0MlRVyCJNiVZW+WDz1r+Qv6IQXgipc53+/9vcGgehKWd90g
         GOl7szAAr+J1ppRYtcrEqjBcAwzNRzoyu4ZNesD0UX3hfQmEI7AD9hsxMQyO43x6kPrh
         GE1tkRWmQL7nmuTCTV5Rr0CPqjS9up04xk6bxzhI5oMZLVRNBpa7AbHBbOlqt4fJzppd
         Pb2Sln7/5mrs9FATDffY/6zVi7QFemAraprIWZNRpRmyKkGeCKiG+SSgwP2tCykfV0ja
         ATUQ==
X-Forwarded-Encrypted: i=1; AL+hErF1efTP0jzrbRGJxYf1ClqH0U2Y0YiROTIOYg8Ef2Q8H2ZVU/LVeG/NjMUarhzYOL6pU4GCB1yCmoKx@vger.kernel.org
X-Gm-Message-State: APuU4Z9eWpN8P4YRnwtB1o/Hwb0kDCyQzibBxwJPV95E247+k6UFNmVZ
	TV8Zaiuq6pMP5oHlw/HfuQmGzGrHBhVV0UhWB2QbqwEnqVUC6YlvN0hTG2YgP6roxKU=
X-Gm-Gg: AYBFou1x2iRHykxWMI0ap1sUHunKuEojOC6naYDrg3rnnhIljup9MbHd7jIFXR9/z+H
	IUfkuzs42wPW1jKGxnfbBk1WK2RULjV1CXzVEG6ytTTFkMUxkw9JWSoe7X714kFCIPQsraeRkyQ
	XiTnfiP3wCXkGONRXCV6sfo5qXI7d4UDyZ789BqzcdXgEjKagwuHbSN3GCxhkyaFEeJO/mK9R9P
	bVu9Nv3TBOUq82jaYCzYQXICGO7c3PNp2kNt5PcCm/7/B5AWrWHql9aJbH1a53wOKZqa7h8exBN
	YVcuKBEFW/koBE724JdKio3Z1hUvPgccMfPSBnUEEx1vtM0uDddmCs5ilTPJAUt2yAOSGdFPzl2
	eIxUJ3XYezPreb4GoB1V7yNInEIj8LbfmgXFBBK2zOu5K9EWgpN3h7CEnXjFdsqtptyYR/i1ver
	RTkGlg1s0gThNo5s3V4ewDmurL0Kcono09C6I7nAX1Sn5HYOBNnvNpHo4GCERL5PDOlXReegcBM
	iKDEgT9dUjs6Ki1MDH1cwVg/NQcNaOsgigQrWGqT/h8MUpxB4My3ke+1n3vrzi2kePXtxRDCbh9
	zFtTN6n9T1CUtqwaHU3G1y1NZYojEJ3Z8cCuAlKwTy+xuSDSIxUqds8v91nDpVKXkx0vwtbaePN
	hz7jDjFq2ywg3MreX
X-Received: by 2002:a05:600d:6510:10b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4bb8881de57mr39648455e9.26.1795173099366;
        Fri, 20 Nov 2026 03:11:39 -0800 (PST)
Received: from localhost (p200300f65f19a904be03815e1634e776.dip0.t-ipconnect.de. [2003:f6:5f19:a904:be03:815e:1634:e776])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb884ab091sm110162205e9.11.2026.11.20.03.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:11:38 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v2 04/10] s390/vfio: Allow untainted use of driver_override
Date: Fri, 20 Nov 2026 12:11:05 +0100
Message-ID:  <a53e12ad841fb18e45b3cf7a4580846943ed0c6d.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=KVkwXeeDf67yBEMp7oUHRQtChMTeOlX43NbtH/KeOAk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhmwGrYvrt8oZ1tuWmU/b73WXTdFsZ91iafF4ge1RU/U3p lTP2cTdyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBE3lix/3f5F7BD8V6NmNW2 s7duzvu1LMMlVuvUhJLk6JyuRJVHZwq+hQQ8WXU5/9fbHBZTlqNJOlnnPmrm5LU8WSFXWFvMGtl RsvOfSmCOZwmHzrETZ89d0azbv2nm8eTWNp2wdQHJaYrl6tde/v30/AKf64SLLpbcS36dvdvune SssVDTwsn3jp9EDFczz2y+tJgZaW8mdMo3WC9b8rnlS1Ja0lq3fZVRlok7+kpS8ve1pOgsdMtJt 9LQ5fD516reuXu/U3GMTvvRlDLWRknP6WnP8o88z5Rzd7/9zU9C+1a9gdmfZXYMdVmW8uu9WPK3 c/H55U2+83Cj6qWg5xmvkoQkP1QukF47Q8Nnktm8nd8A
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Alex Williamson <alex@shazbot.org>

The vfio_ap and vfio_ccw drivers bind devices through driver_override.
With the introduction of the support_driver_override flag in the core
driver struct, it's now required for drivers to declare themselves as
driver_override compatible, otherwise driver_override bindings will be
denied or generate a kernel taint.

Set the support_driver_override flag on the vfio_ap and vfio_ccw driver
structs.

Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/s390/cio/vfio_ccw_drv.c   | 1 +
 drivers/s390/crypto/vfio_ap_drv.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 7546bd137e4e..77765cde87f7 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -375,6 +375,7 @@ static struct css_driver vfio_ccw_sch_driver = {
 	.drv = {
 		.name = "vfio_ccw",
 		.owner = THIS_MODULE,
+		.support_driver_override = true,
 	},
 	.subchannel_type = vfio_ccw_sch_ids,
 	.irq = vfio_ccw_sch_irq,
diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 8e69ed286bb9..2d47dc643269 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -62,6 +62,7 @@ static struct ap_driver vfio_ap_drv = {
 	.on_config_changed = vfio_ap_on_cfg_changed,
 	.on_scan_complete = vfio_ap_on_scan_complete,
 	.ids = ap_queue_ids,
+	.driver.support_driver_override = true,
 };
 
 static void vfio_ap_matrix_dev_release(struct device *dev)
-- 
2.56.0.rc1

