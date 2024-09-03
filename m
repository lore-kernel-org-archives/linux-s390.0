Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E629C156F34
	for <linux-s390@vger.kernel.org>; Tue,  3 Sep 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374397; cv=none; b=Sgd6oPkrhY4DtEke+0E1alYzKpp1veS0pv3TIKOr+DYXywWRlrkBLSCJoMmOciaCKiAVSwGTRfqZyKfu4gkYCXCvwZYPD6WifvTN22Et5mfSi+rFRGhKwhRWcvNtERuToiR5c7l50fKCIxMP8VCYtqDuYQt0+4N63PFCX+XBeiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374397; c=relaxed/simple;
	bh=lJ4aEI+SfYVmS7VzkaKDURPs2wcpEPNtzNdsSTh5Xqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JL+6cRZSeabbO2CjFYD/O/zfdpSi/s+p45l58LEIaRftZKdoGlUikLIDCwg2IUMzHhtVVC+6IKDKXzEGfqqpz1AorwdiA/6H1cyZF5n56813Krm9HdMSlcMYyO2F0HVn6nTeBzIiopuKXxa/wT9ii+9wjpAtI8dpqJ2p1c9c2/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QndBwf92; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QndBwf92"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725374394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPJbr+AV4ff0gStLIX6r7FtGNvxcxGtMDjNsvGlAFzc=;
	b=QndBwf92xNE68kZ4zIA9+ERf3pqDd299f/UsUpxg8zH5Ls2qOmUJZuwF9QkxTp+pMnthJE
	gddfikKHVJqaj2qte0oZGBPaUGUi8TUkWt9l4Z9ZWUHgj6z1GpjSjMCyBw+XNg86nG5w9L
	JmWp5qDd6lyWlSxh1O96HZ+BLv4BH5c=
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com,
	thuth@redhat.com,
	lvivier@redhat.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com,
	atishp@rivosinc.com,
	cade.richard@berkeley.edu,
	jamestiotio@gmail.com
Subject: [kvm-unit-tests PATCH 1/2] configure: Introduce add-config
Date: Tue,  3 Sep 2024 16:39:48 +0200
Message-ID: <20240903143946.834864-5-andrew.jones@linux.dev>
In-Reply-To: <20240903143946.834864-4-andrew.jones@linux.dev>
References: <20240903143946.834864-4-andrew.jones@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Allow users to add additional CONFIG_* and override defaults
by concatenating a given file with #define's and #undef's to
lib/config.h

Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
 configure | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/configure b/configure
index 27ae9cc89657..7a1317d0650d 100755
--- a/configure
+++ b/configure
@@ -64,6 +64,8 @@ usage() {
 	                           no environ is provided by the user (enabled by default)
 	    --erratatxt=FILE       specify a file to use instead of errata.txt. Use
 	                           '--erratatxt=' to ensure no file is used.
+	    --add-config=FILE      specify a file containing configs (CONFIG_*) to add on to the
+	                           generated lib/config.h. Use #undef to override default configs.
 	    --host-key-document=HOST_KEY_DOCUMENT
 	                           Specify the machine-specific host-key document for creating
 	                           a PVM image with 'genprotimg' (s390x only)
@@ -153,6 +155,10 @@ while [[ "$1" = -* ]]; do
 	    erratatxt=
 	    [ "$arg" ] && erratatxt=$(eval realpath "$arg")
 	    ;;
+	--add-config)
+	    add_config=
+	    [ "$arg" ] && add_config=$(eval realpath "$arg")
+	    ;;
 	--host-key-document)
 	    host_key_document="$arg"
 	    ;;
@@ -213,6 +219,10 @@ if [ "$erratatxt" ] && [ ! -f "$erratatxt" ]; then
     echo "erratatxt: $erratatxt does not exist or is not a regular file"
     exit 1
 fi
+if [ "$add_config" ] && [ ! -f "$add_config" ]; then
+    echo "add-config: $add_config does not exist or is not a regular file"
+    exit 1
+fi
 
 arch_name=$arch
 [ "$arch" = "aarch64" ] && arch="arm64"
@@ -502,4 +512,8 @@ cat <<EOF >> lib/config.h
 
 EOF
 fi
+if [ "$add_config" ]; then
+    echo "/* Additional configs from $add_config */" >> lib/config.h
+    cat "$add_config" >> lib/config.h
+fi
 echo "#endif" >> lib/config.h
-- 
2.46.0

