Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674994;
	b=o2NbgrH+mCDecH97UIxORjoKGFwYtcCrPUih1HHFvl6me+6njpBDgsIeO6rqhTq0OuvG
	 txLzyULRjD5nO7Ti4u9ndTwEmfxLJrykkG3JoF9GyZkpfMOkAV3C5uCxdD+zhEtVekPsc
	 wJPq80TVeGMYepY0RLFMHk555xyBp2TtOoXXcB8exiJg+Tlr/8xv8IOyCuepJ7zjC8GoJ
	 2m1ZnQJa5nsVieQk5joFcvixMzMF7m1KkT08puafd1BanzTcLnuYKM+XaELvzSAtxwVNo
	 Mz9soMOzbNbK7KEYVM3AqpRetMa8vmbQXVkY8R4C9Txz3Yy5HsgdonPjHt7Ok4mJLKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674994;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YXT02xbx+UMV7krC+PiVzw1JOPl0AyHZ+SyCM1OQfcg=;
	b=nbKZTJ5h790dbXsieFVmGCh83qC9CLUYErKdftDlAHNJ1uag3eXxcX0iMgAT/6D6XF6T
	 bijY50kXNl1HsXqNRTAFs5QNUMj0jGvhyTcRApk1ykAA8li+bvmPPrO8/nDc7ryzwHcTd
	 z88vaZ2wYfvob8tsD68ocEK1LltDm+cngYV3QEKXkpw5z1l/gzCxwLwzMPnUYQnUx2ouC
	 yv30rZNXYUgGFsvVpe3xIQ4HJ+7FFVS8y37587ep6OqFHkyEGMb8kBqeyFrgtnAgZ70SL
	 EBL9TaJtL+0V+X2IQaVOT57dAUasS6XaU0gj6fEl3rsLZLP8FN6Tr7q/4fpEox/MEtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boN83dZ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EDAAD606A329;
	Tue,  3 Nov 2026 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boN83dZ1
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0FE401F00919;
	Tue,  3 Nov 2026 03:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793674993;
	bh=YXT02xbx+UMV7krC+PiVzw1JOPl0AyHZ+SyCM1OQfcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=boN83dZ1Gwykx0l1Wr8brt/OVt0lXGbwXXNyL/4RZsqUI2YwzywyyXipKCMiipNDE
	 rGeepw+aNZKSBAvl2lkh78+i+IC0BMjKSs0rgjpmAomAhenapWJnvvtd6bwMtWWuz4
	 RA6oKG7XVBCMWq0Bes/8ROK5hL6PobPmwrIRpJ91xh6FGfMMzVSmbqny2dd/ljIrTg
	 7tdh91GF+OEuIPObRwkAN/t+nOqUwcdShfId53sRQIS7whi/3JlLUi0iSdCTCRNgl0
	 z79e6ncUsRV4taIOEeE5VlmE/WoFjXGcoZi0zB3t4tnafAUy6/8xySd0hg5f3ov5AQ
	 qkmu9nFkea4gw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	linux-s390@vger.kernel.org (open list:S390 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [RFC PATCH v2 06/11] s390/cert_store: Track subsystem keys instead of re-registering key_type
Date: Tue,  3 Nov 2026 05:02:11 +0200
Message-ID: <20261103030226.2685251-7-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103030226.2685251-1-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
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

cert_store refreshes its keyring by unregistering and re-registering
key_type_cert_store_key so key_type_dead garbage collection sweeps old
keys, while leaving userspace-linked keys behind.

The removal of key_type_dead will eliminate that sweep.

Register key_type_cert_store_key once during init before creating sysfs
attributes, and track subsystem-created keys explicitly so refresh
unlinks and invalidates previous entries directly.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/s390/kernel/cert_store.c | 161 ++++++++++++++--------------------
 1 file changed, 67 insertions(+), 94 deletions(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index 998f2da56175..ab1a78cdfd4c 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -17,6 +17,7 @@
 #include <linux/key.h>
 #include <linux/keyctl.h>
 #include <linux/kobject.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -296,6 +297,18 @@ static int check_certificate_valid(const struct vce *vce)
 	return check_certificate_hash(vce);
 }
 
+struct cert_store_key {
+	struct list_head list;
+	struct key *key;
+};
+
+static DEFINE_MUTEX(cs_refresh_lock);
+/* Owned references, protected by cs_refresh_lock. */
+static LIST_HEAD(cs_keys);
+static struct key *active_cs_keyring;
+static struct key *cs_keyring_parent;
+
+/* Return an owned reference to the user session keyring. */
 static struct key *get_user_session_keyring(void)
 {
 	key_ref_t us_keyring_ref;
@@ -305,118 +318,66 @@ static struct key *get_user_session_keyring(void)
 	if (IS_ERR(us_keyring_ref)) {
 		pr_dbf_msg("Couldn't get user session keyring: %ld",
 			   PTR_ERR(us_keyring_ref));
-		return ERR_PTR(-ENOKEY);
+		return ERR_CAST(us_keyring_ref);
 	}
-	key_ref_put(us_keyring_ref);
 	return key_ref_to_ptr(us_keyring_ref);
 }
 
-/* Invalidate all keys from cert_store keyring. */
-static int invalidate_keyring_keys(struct key *keyring)
-{
-	unsigned long num_keys, key_index;
-	size_t keyring_payload_len;
-	key_serial_t *key_array;
-	struct key *current_key;
-	int rc;
-
-	keyring_payload_len = key_type_keyring.read(keyring, NULL, 0);
-	num_keys = keyring_payload_len / sizeof(key_serial_t);
-	key_array = kzalloc_objs(key_serial_t, num_keys);
-	if (!key_array)
-		return -ENOMEM;
-
-	rc = key_type_keyring.read(keyring, (char *)key_array, keyring_payload_len);
-	if (rc != keyring_payload_len) {
-		pr_dbf_msg("Couldn't read keyring payload");
-		goto out;
-	}
-
-	for (key_index = 0; key_index < num_keys; key_index++) {
-		current_key = key_lookup(key_array[key_index]);
-		pr_dbf_msg("Invalidating key %08x", current_key->serial);
-
-		key_invalidate(current_key);
-		key_put(current_key);
-		rc = key_unlink(keyring, current_key);
-		if (rc) {
-			pr_dbf_msg("Couldn't unlink key %08x: %d", current_key->serial, rc);
-			break;
-		}
-	}
-out:
-	kfree(key_array);
-	return rc;
-}
-
-static struct key *find_cs_keyring(void)
-{
-	key_ref_t cs_keyring_ref;
-	struct key *cs_keyring;
-
-	cs_keyring_ref = keyring_search(make_key_ref(get_user_session_keyring(), true),
-					&key_type_keyring, CERT_STORE_KEYRING_NAME,
-					false);
-	if (!IS_ERR(cs_keyring_ref)) {
-		cs_keyring = key_ref_to_ptr(cs_keyring_ref);
-		key_ref_put(cs_keyring_ref);
-		goto found;
-	}
-	/* Search default locations: thread, process, session keyrings */
-	cs_keyring = request_key(&key_type_keyring, CERT_STORE_KEYRING_NAME, NULL);
-	if (IS_ERR(cs_keyring))
-		return NULL;
-	key_put(cs_keyring);
-found:
-	return cs_keyring;
-}
-
 static void cleanup_cs_keys(void)
 {
-	struct key *cs_keyring;
+	struct cert_store_key *entry, *tmp;
+	int rc;
 
-	cs_keyring = find_cs_keyring();
-	if (!cs_keyring)
+	if (!active_cs_keyring)
 		return;
 
-	pr_dbf_msg("Found cert_store keyring. Purging...");
-	/*
-	 * Remove cert_store_key_type in case invalidation
-	 * of old cert_store keys failed (= severe error).
-	 */
-	if (invalidate_keyring_keys(cs_keyring))
-		unregister_key_type(&key_type_cert_store_key);
+	/* Invalidate even certificates unlinked or linked into other keyrings. */
+	list_for_each_entry_safe(entry, tmp, &cs_keys, list) {
+		key_invalidate(entry->key);
+		key_put(entry->key);
+		list_del(&entry->list);
+		kfree(entry);
+	}
 
-	keyring_clear(cs_keyring);
-	key_invalidate(cs_keyring);
-	key_put(cs_keyring);
-	key_unlink(get_user_session_keyring(), cs_keyring);
+	rc = keyring_clear(active_cs_keyring);
+	if (rc)
+		pr_dbf_msg("Couldn't clear cert_store keyring: %d", rc);
+	key_invalidate(active_cs_keyring);
+	rc = key_unlink(cs_keyring_parent, active_cs_keyring);
+	if (rc)
+		pr_dbf_msg("Couldn't unlink cert_store keyring: %d", rc);
+	key_put(active_cs_keyring);
+	key_put(cs_keyring_parent);
+	active_cs_keyring = NULL;
+	cs_keyring_parent = NULL;
 }
 
+/* Return a borrowed reference; cleanup_cs_keys() owns the keyring. */
 static struct key *create_cs_keyring(void)
 {
-	static struct key *cs_keyring;
+	struct key *cs_keyring, *parent;
 
 	/* Cleanup previous cs_keyring and all associated keys if any. */
 	cleanup_cs_keys();
+	parent = get_user_session_keyring();
+	if (IS_ERR(parent))
+		return parent;
+
 	cs_keyring = keyring_alloc(CERT_STORE_KEYRING_NAME, GLOBAL_ROOT_UID,
 				   GLOBAL_ROOT_GID, current_cred(),
 				   (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | KEY_USR_READ,
 				   KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP,
-				   NULL, get_user_session_keyring());
+				   NULL, parent);
 	if (IS_ERR(cs_keyring)) {
 		pr_dbf_msg("Can't allocate cert_store keyring");
-		return NULL;
+		key_put(parent);
+		return cs_keyring;
 	}
 
+	active_cs_keyring = cs_keyring;
+	cs_keyring_parent = parent;
 	pr_dbf_msg("Successfully allocated cert_store keyring: %08x", cs_keyring->serial);
 
-	/*
-	 * In case a previous clean-up ran into an
-	 * error and unregistered key type.
-	 */
-	register_key_type(&key_type_cert_store_key);
-
 	return cs_keyring;
 }
 
@@ -454,6 +415,7 @@ static char *get_key_description(struct vcssb *vcssb, const struct vce *vce)
 static int create_key_from_vce(struct vcssb *vcssb, struct vce *vce,
 			       struct key *keyring)
 {
+	struct cert_store_key *entry;
 	key_ref_t newkey;
 	char *desc;
 	int rc;
@@ -462,6 +424,13 @@ static int create_key_from_vce(struct vcssb *vcssb, struct vce *vce,
 	if (!desc)
 		return -ENOMEM;
 
+	/* Reserve cleanup tracking before the key can be linked elsewhere. */
+	entry = kmalloc_obj(*entry);
+	if (!entry) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
 	newkey = key_create_or_update(
 		make_key_ref(keyring, true), CERT_STORE_KEY_TYPE_NAME,
 		desc, (u8 *)vce + vce->vce_hdr.vc_offset,
@@ -473,10 +442,12 @@ static int create_key_from_vce(struct vcssb *vcssb, struct vce *vce,
 	if (rc) {
 		pr_dbf_msg("Couldn't create a key from Certificate Entry (%d)", rc);
 		rc = -ENOKEY;
+		kfree(entry);
 		goto out;
 	}
 
-	key_ref_put(newkey);
+	entry->key = key_ref_to_ptr(newkey);
+	list_add_tail(&entry->list, &cs_keys);
 out:
 	kfree(desc);
 	return rc;
@@ -704,19 +675,18 @@ static int fill_cs_keyring(void)
 	if (rc)
 		goto cleanup_keys;
 
-	rc = -ENOMEM;
 	cs_keyring = create_cs_keyring();
-	if (!cs_keyring)
+	if (IS_ERR(cs_keyring)) {
+		rc = PTR_ERR(cs_keyring);
 		goto cleanup_keys;
+	}
 
 	rc = add_certificates_to_keyring(vcssb, cs_keyring);
 	if (rc)
-		goto cleanup_cs_keyring;
+		goto cleanup_keys;
 
 	goto out;
 
-cleanup_cs_keyring:
-	key_put(cs_keyring);
 cleanup_keys:
 	cleanup_cs_keys();
 out:
@@ -724,7 +694,6 @@ static int fill_cs_keyring(void)
 	return rc;
 }
 
-static DEFINE_MUTEX(cs_refresh_lock);
 static int cs_status_val = -1;
 
 static ssize_t cs_status_show(struct kobject *kobj,
@@ -794,14 +763,18 @@ static int __init cert_store_init(void)
 	if (!cert_store_kobj)
 		goto cleanup_dbf;
 
-	rc = sysfs_create_files(cert_store_kobj, cert_store_attrs);
+	rc = register_key_type(&key_type_cert_store_key);
 	if (rc)
 		goto cleanup_kobj;
 
-	register_key_type(&key_type_cert_store_key);
+	rc = sysfs_create_files(cert_store_kobj, cert_store_attrs);
+	if (rc)
+		goto cleanup_key_type;
 
 	return rc;
 
+cleanup_key_type:
+	unregister_key_type(&key_type_cert_store_key);
 cleanup_kobj:
 	kobject_put(cert_store_kobj);
 cleanup_dbf:
-- 
2.47.3

