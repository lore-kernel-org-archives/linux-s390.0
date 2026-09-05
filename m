Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C993749F7;
	Sat,  5 Sep 2026 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638349; cv=none; b=Ue7jGonGLk/Xa907fMnxcjy3mX30CfXR63sXDXg7JvRtiYXolrlSeumk+g0werbJ/gtK40EfeK8uLPSI2T1+VdZyqPPsqTVIsd7G3MEkyTNIb6fOM9njL+fQeetzae5eNj7J/3w2SjXeP0sVhW/oIJ0tUjz/I3PSvyH0luhhBaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638349; c=relaxed/simple;
	bh=Up2SyTBOKxVVjiQJQUfFXmKSs4AmV82GPZ4keuC02Ho=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F13u2Q2Ywn3PZM2IGrf9PUDfE0RRHlYbCcAhpmm7CuVchOQ/g+d0BAUN4Ds4dU+qjfh1Cg6JeMakOlykIvNfyQ2heWMY/FCGADPC10eYYDAOlUdaosyOp4NHSRy0ydCEnJGAyZGzTms3eZLIT2LLpbDRrXy9gX13G7kFswhERVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nECnwvJk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nECnwvJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76211F00A3D;
	Sat,  5 Sep 2026 19:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638347;
	bh=KNybveUt2cbmJtkR6lO0M2kAXLE5Q/PY5RA8hbJXao0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nECnwvJkW9DIUi2MtiqR0u4gybTRriE/l2KIRLKjJM+Zb3n9VLfxz88kj4+KrOh4o
	 TqPnZoHqdOT/viLMqF9TZZ6IWyIfD/Lxf7FaPLkPFHvi8NJ8Z957IJiv8SyvJ8ZsPl
	 8tMJP7PHVD0XkC6MuWOPnsidPxcxCBSJF3ynzYPlSmAzaPp/ue/mvzFTyCAfyWdlMk
	 QLsHoMMbsCznL9wnvaxYjsVHODqQ7nlxkpEbha4lKfnkEI36x643uwPi45mQxZ7j63
	 I9S3+qdAp3Ph3n+6HWv3wO13fBPg6XM6JAXi+BxkP97lritUwTv4o87DQyihNn4DK2
	 KHobIvkXEAs/A==
Subject:
 Re: [PATCH net] s390/qeth: allow bridgeport queries despite OS_MISMATCH
From: netdev-bot+sashiko@kernel.org
To: nagamani@linux.ibm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
 pasic@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, Eugene.Crosser@ru.ibm.com, ubraun@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 05 Sep 2026 19:59:06 +0000
Message-ID: <178863834632.219967.10151398782993596479@kernel.org>
In-Reply-To: <20260901155344.3561483-1-nagamani@linux.ibm.com>
References: <20260901155344.3561483-1-nagamani@linux.ibm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 0

- [High] qeth_bridgeport_query_ports_cb() now returns success on
  IPA_RC_SBP_IQD_OS_MISMATCH and therefore executes…
- [Medium] The new OS_MISMATCH exception in
  qeth_bridgeport_query_ports_cb()…
- [Medium] qeth_bridge_port_role_state_show() can now emit "none (OS
  family mismatch)\n" for the read-write attribute bridge_role…

--

s390/qeth: allow bridgeport queries despite OS_MISMATCH

This treats IPA_RC_SBP_IQD_OS_MISMATCH as success for
QUERY_BRIDGE_PORTS so that bridge_role and bridge_state stay readable
when another OS family owns the bridge port, and passes a new
os_mismatch out-parameter up to sysfs so the role can be printed as
"none (OS family mismatch)".  SET operations keep returning -EPERM.

A few questions about the new code below.

> diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
> index a9e7d1d637a20..2935c2ecc314b 100644
> --- a/drivers/s390/net/qeth_l2_main.c
> +++ b/drivers/s390/net/qeth_l2_main.c
> @@ -1158,7 +1158,7 @@ static void qeth_l2_setup_bridgeport_attrs(struct qeth_card *card)
>  		qeth_bridgeport_setrole(card, card->options.sbp.role);
>  		/* Let the callback function refresh the stored role value. */
>  		qeth_bridgeport_query_ports(card, &card->options.sbp.role,
> -					    NULL);
> +					    NULL, NULL);
>  	}
>  	if (card->options.sbp.hostnotification) {
>  		if (qeth_bridgeport_an_set(card, 1))

[ ... ]

> @@ -1721,10 +1722,19 @@ static int qeth_bridgeport_query_ports_cb(struct qeth_card *card,
>  	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
>  	struct _qeth_sbp_cbctl *cbctl = (struct _qeth_sbp_cbctl *)reply->param;
>  	struct qeth_sbp_port_data *qports;
> +	u16 sbp_rc;
>  	int rc;
>  
>  	QETH_CARD_TEXT(card, 2, "brqprtcb");
> -	rc = qeth_bridgeport_makerc(card, cmd);
> +	sbp_rc = cmd->data.sbp.hdr.return_code;
> +
> +	/* on OS family mismatch, query still returns valid port data;
> +	 * treat as success
> +	 */
> +	if (sbp_rc == IPA_RC_SBP_IQD_OS_MISMATCH && !cmd->hdr.return_code)
> +		rc = 0;
> +	else
> +		rc = qeth_bridgeport_makerc(card, cmd);
>  	if (rc)
>  		return rc;

[Severity: Medium]
Should this test also be qualified with IS_IQD(card)?

qeth_bridgeport_makerc() decodes the very same
cmd->data.sbp.hdr.return_code field in a card-type dependent way:

drivers/s390/net/qeth_l2_main.c:qeth_bridgeport_makerc() {
	if ((IS_IQD(card) && ipa_rc == IPA_RC_SUCCESS) ||
	    (!IS_IQD(card) && ipa_rc == sbp_rc)) {
		switch (sbp_rc) {
		...
		case IPA_RC_SBP_OSA_OS_MISMATCH:
		case IPA_RC_SBP_IQD_OS_MISMATCH:
			rc = -EPERM;
	...
	} else {
		switch (ipa_rc) {
		...
		default:
			rc = -EIO;
	}
}

and the two families use different numbering in qeth_core_mpc.h:

	IPA_RC_SBP_IQD_OS_MISMATCH	= 0x0010,
	IPA_RC_SBP_OSA_OS_MISMATCH	= 0x2B10,

On an OSA (non-IQD) card, a reply carrying ipa_rc == 0 and sbp_rc ==
0x0010 is not an OS mismatch in the OSA numbering, yet the new shortcut
turns it into success, parses port_data as valid role/state and reports
"none (OS family mismatch)" to userspace, where makerc() would have
returned -EIO through its else branch.

The opposite direction is a genuine OSA mismatch (ipa_rc == sbp_rc ==
0x2B10), which is not whitelisted here, so bridge_role and bridge_state
reads on OSA bridgeports keep failing with -EPERM.

Related, the new kernel-doc for the out-parameter says

 * @os_mismatch: if non-NULL, set to true when firmware reports
 *		 OS family mismatch.

which reads more generic than an IQD-only implementation.  Would it make
sense to either extend the check to IPA_RC_SBP_OSA_OS_MISMATCH with the
OSA ipa_rc == sbp_rc convention, or document it as IQD-only?

> @@ -1740,6 +1750,9 @@ static int qeth_bridgeport_query_ports_cb(struct qeth_card *card,
>  		if (cbctl->data.qports.state)
>  			*cbctl->data.qports.state = qports->entry[0].state;
>  	}
> +	if (cbctl->data.qports.os_mismatch)
> +		*cbctl->data.qports.os_mismatch =
> +			(sbp_rc == IPA_RC_SBP_IQD_OS_MISMATCH);
>  	return 0;
>  }

[Severity: High]
Can this discard the user's configured bridge port role?

Because the callback no longer returns early with -EPERM on OS mismatch,
it now falls through to the role store just above:

drivers/s390/net/qeth_l2_main.c:qeth_bridgeport_query_ports_cb() {
	if (qports->num_entries > 0) {
		if (cbctl->data.qports.role)
			*cbctl->data.qports.role = qports->entry[0].role;
	...
}

Both callers pass the persistent configuration field as that
out-parameter, qeth_l2_setup_bridgeport_attrs() with
&card->options.sbp.role and qeth_bridge_port_role_state_show() likewise,
so the firmware placeholder role "none" described in the commit message
gets written into card->options.sbp.role.

That has a few follow-on effects.  A read-only sysfs read of bridge_role
mutates stored configuration.  Re-application of the role is then gated
off for good:

drivers/s390/net/qeth_l2_main.c:qeth_l2_setup_bridgeport_attrs() {
	if (!card->options.sbp.reflect_promisc &&
	    card->options.sbp.role != QETH_SBP_ROLE_NONE) {
		qeth_bridgeport_setrole(card, card->options.sbp.role);
	...
}

so once the field has been zeroed, no later set-online or recovery
retries qeth_bridgeport_setrole(), even after the other OS family
releases the port.

The same field also feeds the mutual-exclusion predicate:

drivers/s390/net/qeth_l2.h:qeth_bridgeport_is_in_use() {
	return card->options.sbp.role ||
	       card->options.sbp.reflect_promisc ||
	       card->options.sbp.hostnotification;
}

Zeroing sbp.role flips that to false and unblocks the VNICC set/get
paths, qeth_l2_bridge_getlink(), the learning-sync path, and makes
bridge_reflect_promisc writable while a bridge role is configured.

A sequence that reaches this: write "primary" to bridge_role while
offline (stored without a firmware command), then set the device online;
qeth_bridgeport_setrole() still fails with -EPERM under mismatch, and the
following qeth_bridgeport_query_ports(card, &card->options.sbp.role,
NULL, NULL) now succeeds and overwrites the field with "none".  A single
read of bridge_role while online reproduces the same clobbering.

Would it work to publish the placeholder role only into the local sysfs
output and leave card->options.sbp.role untouched in the mismatch case?

> diff --git a/drivers/s390/net/qeth_l2_sys.c b/drivers/s390/net/qeth_l2_sys.c
> index 7f592f9125172..7101be62eb1d5 100644
> --- a/drivers/s390/net/qeth_l2_sys.c
> +++ b/drivers/s390/net/qeth_l2_sys.c
> @@ -25,7 +26,7 @@ static ssize_t qeth_bridge_port_role_state_show(struct device *dev,
>  	if (qeth_card_hw_is_reachable(card) &&
>  					card->options.sbp.supported_funcs)
>  		rc = qeth_bridgeport_query_ports(card,
> -			&card->options.sbp.role, &state);
> +			&card->options.sbp.role, &state, &os_mismatch);
>  	if (!rc) {
>  		if (show_state)
>  			switch (state) {

[ ... ]

> @@ -52,6 +53,10 @@ static ssize_t qeth_bridge_port_role_state_show(struct device *dev,
>  		if (rc)
>  			QETH_CARD_TEXT_(card, 2, "SBP%02x:%02x",
>  				card->options.sbp.role, state);
> +		else if (!show_state &&
> +			 card->options.sbp.role == QETH_SBP_ROLE_NONE &&
> +			 os_mismatch)
> +			rc = sysfs_emit(buf, "%s (OS family mismatch)\n", word);
>  		else
>  			rc = sysfs_emit(buf, "%s\n", word);
>  	}

[Severity: Medium]
Can the value emitted here be written back to the same attribute?

bridge_role is read/write:

drivers/s390/net/qeth_l2_sys.c:
static DEVICE_ATTR(bridge_role, 0644, qeth_bridge_port_role_show,
		   qeth_bridge_port_role_store);

and the store side accepts only the bare tokens:

drivers/s390/net/qeth_l2_sys.c:qeth_bridge_port_role_store() {
	if (sysfs_streq(buf, "primary"))
		role = QETH_SBP_ROLE_PRIMARY;
	else if (sysfs_streq(buf, "secondary"))
		role = QETH_SBP_ROLE_SECONDARY;
	else if (sysfs_streq(buf, "none"))
		role = QETH_SBP_ROLE_NONE;
	else
		return -EINVAL;
	...
}

sysfs_streq() tolerates a trailing newline but not the
" (OS family mismatch)" suffix, so a read-modify-write or a
save-and-restore of bridge_role by the zdev tooling named in the commit
message (chzdev save/restore) would get -EINVAL, and parsers that exact
match "none" no longer recognize the role string.  This is emitted while
the card is reachable and sbp is supported, that is exactly when store()
is otherwise usable.

There is no Documentation/ABI entry for this attribute, so store() is the
only in-tree description of the value space.  Should the mismatch
indication go somewhere other than the value of a writable attribute, or
should store() learn to accept the decorated form?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901155344.3561483-1-nagamani%40linux.ibm.com
