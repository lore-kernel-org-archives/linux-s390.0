Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426651;
	b=xZnHEJKNWmQ9Z3+XNcFESWq9NhE8cVuB0KiaZ3Xl+j/gzHh3v6yUHx0YTxa+CsKS29I2
	 330V2cjNj+WSr8YzDbVS6glVeCa45hSlTNYaN71l5vnkehrhKOXIw/ANIfEZ8TWCxO/ZP
	 lnoE3ieNk+CXQ7tc1YWKeWN+cXPzuLRwqbj9ijH0td7XCk/kKwHV1Vc+dULrQWyqcAUrl
	 CU6WLoSn3qBUpjb3nhzExlQa35zWE72JX66JDzylOJv2Io+1ytllDqeawPr2d0dYx2TJl
	 ajO26Q42P7sXd+DE3zPnmpAtHaFBL+RLxPu2y9H5UT+seHquewuf/fjdd/zhWHJK/7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426651;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=dQUU5u79vuDftzZPq41mVfEGZTZsxAT4nxqA9JHwFwM=;
	b=vaTEAl1x6+SY1hB4kWiJzacLoeOC2IJq9bKDpUn1kVZ7DqioQmjX4rWahuCtHWb5r0dO
	 tnlkVxk3EvsHH+ac2HxuXkcL17L3eENzqfLVXlIAPt0h7xCogEEbwKSvKVtiv2QXgfJJe
	 s8pWsnGoZ8l8QpFDMu86cm32PBXVTFqts5fWwCxiO0kbcGz1phkvvrbFRwonJuRrR5RpI
	 VOhRHGQkof1seGChi0Tf8cllcX+bipMEAZLl4M2kPOoLgEWwgxyxfIStb6GCSehd4RUUu
	 IZWMkYVktFCvyfUywWHEgpvDPhZRKU1YEs5LwlbjRtdD1XO3m1zn5Glv2irGt8ZWLMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2BRs8kNn;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=orqM62jb;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259F606A6B3;
	Mon, 23 Nov 2026 09:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A259F606A6B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2BRs8kNn;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=orqM62jb
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQUU5u79vuDftzZPq41mVfEGZTZsxAT4nxqA9JHwFwM=;
	b=2BRs8kNnJh8jUvFne0pup0kjd56RKwfZQoVTswB8jaQkT/1+UC3J0057egOH4HK7xFJAqA
	HqCywtOh7slUrHcQGQvefA6eL7zyv5hsSA1zxFFvN/6ge8RI/bO/4bG9ak1pAwLXjgZqj6
	iGcErJRTwGr5nVvFFDPmW/Nm8laVaZu6XMnvCEkeIwUojmTfuvrSIQyqYv8EdmwCWWVV1W
	ki1aQCBFjitTjq+qvrPiLfH9aOLweh50rgCPL57R9s9qzuuIqDA61unszxi5VtgurELgBe
	RanufkaLmGxg3YO/o8/JlKLnrf6Pe3A3XF6OnxlZIDqBXd9EKN0qE98NapY4hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQUU5u79vuDftzZPq41mVfEGZTZsxAT4nxqA9JHwFwM=;
	b=orqM62jbjJv4cXHhrjV4L7jD4t6CApiSqCiCMjGa0zhR8JXKvf+tjoeh2jm1k5ccyk1y6u
	4vDc7mLpel0lpJCg==
Date: Mon, 23 Nov 2026 10:37:11 +0100
Subject: [PATCH v3 06/15] arm64: Remove AT_VECTOR_SIZE_ARCH from UAPI
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-at-vector-size-arch-v3-6-d342dae9e843@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
In-Reply-To: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=1590;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=y+NTI479tyoHV6O0h6k1NetFm2TSA10tCjlo/HGZYvg=;
 b=R4duhjDRQUXysUPjCyGoikenj+2lzks0w9tUzNKNfbwsEci78RXNuIVq9fOyG8pXBz36DsOCf
 bTSsZCwaQ+5AeQSIEa48ysbBSHeolzWma3r0l38rQVQGcphJQ8frdez
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/arm64/include/asm/auxvec.h      | 7 +++++++
 arch/arm64/include/uapi/asm/auxvec.h | 6 ++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/auxvec.h b/arch/arm64/include/asm/auxvec.h
new file mode 100644
index 000000000000..de24eaaa06e2
--- /dev/null
+++ b/arch/arm64/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_AUXVEC_H
+#define __ASM_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 2 /* entries in ARCH_DLINFO */
+
+#endif
diff --git a/arch/arm64/include/uapi/asm/auxvec.h b/arch/arm64/include/uapi/asm/auxvec.h
index 743c0b84fd30..fb51e906813a 100644
--- a/arch/arm64/include/uapi/asm/auxvec.h
+++ b/arch/arm64/include/uapi/asm/auxvec.h
@@ -14,13 +14,11 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-#ifndef __ASM_AUXVEC_H
-#define __ASM_AUXVEC_H
+#ifndef __UAPI_ASM_AUXVEC_H
+#define __UAPI_ASM_AUXVEC_H
 
 /* vDSO location */
 #define AT_SYSINFO_EHDR	33
 #define AT_MINSIGSTKSZ	51	/* stack needed for signal delivery */
 
-#define AT_VECTOR_SIZE_ARCH 2 /* entries in ARCH_DLINFO */
-
 #endif

-- 
2.56.1

