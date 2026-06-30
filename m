Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1F83988F9;
	Tue, 30 Jun 2026 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820462; cv=none; b=TmKNudG9UUuWjqMRAVCQEPci6EfYXOOJS83XQ9E196H3ATrdq+IEWWEG3UdoMYyU09V9XWKsJp+wmmj1AVxUfWBeUSQxwzCKhRh5RN0NO7kjWHf2fSP+pYbSXFPLv337rU9xCUIMuDotwfLVvNA+4xCMTIbrtvljyF/+0ryDU4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820462; c=relaxed/simple;
	bh=DibPbFIxxi9nBLUrPdm+SjNp8uKtA4niqUO3GL49to4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VFZl9fJ0K6/7gKW/Z98HoN9dPln2l/A+5CC/WEiFYadTOu94lxOxxeBCXOiz66Ba5Wo7mLmnFC9b9vLNzzeS+89rkE1F94qVpDfU+9gK0GwXrvt/3fdio9YiNGeKPP2XC2F+Lsyg95yXzEemdNuJX/G/rBS1MlPUFl0aLNroj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xwrs1HbV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xwrs1HbV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF07A1F000E9;
	Tue, 30 Jun 2026 11:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782820460;
	bh=XCe0JeB8T+Na5yilUwWe7+hNYcs1hjxUMt9lG7WIRBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xwrs1HbV0JsZOsoY18A/Y5F1NVpGQN1SXqoNAMB2wYD9wPO9tA692TvP0pTfhTTuI
	 +yunVdybeG+xOmHrHD0FDxWprmw6l2TgKucbZbVBHuswQVVTCnPTsseV934rbIKS8V
	 7c9oVEL+swR1izh5brc+hVlbe6omEeJw4ymFX3akSeGX6xWiGAPjy9FQn37Ho0sVUg
	 4cuSK7C+L8kbffE3TgpMXGGj2ZbJNkP1KttA3wZhxPO3bmTII0/f+dLkq7KOMbeSVi
	 FhgpEzmeXblY4lP4aPBRcLA/+rLzm74qsdBh5+9tpP1H1yhyWUB/Czi2QPfuTO3M24
	 zql2isdrDrkNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/15] s390/vfio-ap: Add live guest migration chapter
 to vfio-ap.rst
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260630104132.1598851-16-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
 <20260630104132.1598851-16-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:54:19 +0000
Message-Id: <20260630115419.DF07A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Malformed reStructuredText syntax leading to potential build warnin=
gs (grid table and nested lists).
- [Low] Multiple typographical, grammatical errors, and inconsistent variab=
le names in the newly added text.
- [Low] Logical contradiction in section heading.
--

commit 5afeaef82632a184153d66843b7e2a58e98d0cdd
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst
   =20
This commit adds a 'Live Guest Migration' chapter to the vfio-ap.rst
documentation. It describes the details for initiating live guest migration
for a guest to which AP adapters, domains and control domains have been
passed through.

> diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s39=
0/vfio-ap.rst
> index ac0c07f76ddd7..fc0707c0dffd6 100644
> --- a/Documentation/arch/s390/vfio-ap.rst
> +++ b/Documentation/arch/s390/vfio-ap.rst

[ ... ]

> +To be considered compatible, the AP configuration for the destination ho=
st must
> +meet these requirements:
> =20
> -      (QEMU) device-del id=3D<device-id>
> +* Each AP adapter, domain and control domain number assigned to the sour=
ce
> +  guest's AP configuration must be in the destination host's AP
> +  configuration. This can be verified as follows:
> =20
> -      For example, to hot unplug the vfio_ap mediated device that was sp=
ecified
> -      on the qemu command line with 'id=3Dhostdev0' when the guest was s=
tarted:
> +  * On the source host, display the AP configuration of the source guest:
> =20
> -         (QEMU) device-del id=3Dhostdev0
> +    .. code-block:: bash
> =20
> -After live migration of the KVM guest completes, an AP configuration can=
 be
> -restored to the KVM guest by hot plugging a vfio_ap mediated device on t=
he target
> -system into the guest in one of two ways:
> +       cat /sys/devices/vfio_ap/matrix/$UUID/guest_matrix
> +       cat /sys/devices/vfio_ap/matrix/$UUID/control_domains
> =20
> -1. If the KVM guest was started with libvirt, you can hot plug a matrix =
mediated
> -   device into the guest via the following virsh commands:
> +    .. note::
> +       Replace ``$UUID`` with the actual UUID of your mediated device.
> =20
> -   virsh attach-device <guestname> <path-to-device-xml>
> +  * Display the AP configuration of the destination host:
> =20
> -      For example, to hot plug mdev 62177883-f1bb-47f0-914d-32a22e3a8804=
 into
> -      the guest named 'my-guest':
> +    .. code-block:: bash
> =20
> -         virsh attach-device my-guest ~/config/my-guest-hostdev.xml
> +       lszcrypt -V
> +       cat /sys/bus/ap/ap_control_domain_mask
> =20
> -            The contents of my-guest-hostdev.xml:
> +    Note that each bit in the ap_control_domain_mask corresponds to
> +    correspond to domain numbers 0-255. If a bit is set to one, then

[Severity: Low]
This isn't a bug, but the phrase "corresponds to correspond to" appears
to be duplicated.

> +    the control domain is available on the destination host. For
> +    example:

[ ... ]

> ++-----------------------------------------------------------------------=
------+
> +| Table Keys                                                            =
      |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
> +|                                                                       =
      |
> +| [1]        The hardware capability must be the same for both the sourc=
e     |
> +|            and destination queue device.                              =
      |
> +|                                                                       =
      |
> +| [2]        The source and destination queues must either both have    =
      |
> +|            full native card function or both have stateless functions.=
      |
> +|            If the functional capabilities don't match, then the source=
      |
> +|            queue can have stateless capabilities since full native car=
d     |
> +|            function can handle stateless functions; otherwise, migrati=
on    |
> +|            will fail.                                                 =
      |
> +|                                                                       =
      |
> +| [3]        The AP type on the source and destination guests can       =
      |
> +|            differ if the queue passed through to the target guest is a=
      |
> +|            newer model (backwards compatible)                         =
      |
> ++--------------+--------------------------------------------------------=
------+

[Severity: Low]
Will this malformed table bottom border cause sphinx build warnings?

The table body defines a single column, but the bottom border is split
into two columns by the + character, which violates reStructuredText grid=20
table syntax.

> +
> +* To verify the hardware capabilities are compatible:
> +
> +  * On both the source and destination hosts, display the hardware capab=
ilities
> +    for each AP adapter in the AP configuration for that host::
> +
> +       cat /sys/bus/ap/devices/card$APID/ap_functions
> +
> +    .. note::
> +       The ``$APID`` is the two-character adapter number in hexidecimal =
format;

[Severity: Low]
This isn't a bug, but there is a typo in the word "hexidecimal".

> +       for example, card02 or card1f. The ``/sys/bus/ap/devices`` direct=
ory
> +       also lists the APQNs of the queue devices installed in the respec=
tive
> +       host system with the first two characters being the APID.
> +
> +  * Verify the hardware capabilities for each AP adapter device on the s=
ource
> +    and destination host are compatible. The ``ap_functions`` attribute =
is a
> +    bitmask. The bits in the mask read from left to right starting with =
bit 0.
> +    Each bit that is set to one indicates the corresponding hardware cap=
ability
> +    is installed:
> +
> +    * Bits 0-3 are the facilities bits. Each bit value must match for th=
e AP
> +      devices on the source and destination systems. The values indicate=
 the
> +      following:
> +      * bit-0: APSC is installed
> +      * bit-1: AP4KM is installed
> +      * bit-2: AP4KC is installed

[Severity: Low]
Is a blank line needed before the nested list items (starting with bit-0)
to avoid reStructuredText parsing warnings?

> +
> +    * Bits 3-5 specify the adapter Modes. Only one of these bits will be=
 set to
> +      one and must be the same for both the source and destination adapt=
er
> +      devices:
> +      * bit-3: CCA-mode
> +      * bit-4: Accelerator-mode
> +      * bit-5: XCP-mode (EP11)
> +
> +    * Bit 6 specifies whether APXA is installed and must be the same for=
 both
> +      the source and destination adapter devices.
> +
> +    * Bit 7 specifies command whether command filtering is installed

[Severity: Low]
This isn't a bug, but the phrase "command whether command filtering" has
duplicated words.

> +      and must be the same for both the source and destination adapter d=
evices.

[ ... ]

> +One or more queues are not bound to the vfio_ap driver on the destinatio=
n host
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
> +The queue devices passed through to the source guest are not installed i=
n the
> +destination host or are not bound to its vfio_ap device driver.
> +
> +**Source host**
> +
> ++--------------+--------------------------------------------------------=
--------+
> +| Log          | Message                                                =
        |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> +| Console log: | error: operation failed: migration failed. Message from=
 the    |
> +|              | source host: operation failed: job 'migration out' fail=
ed:     |
> +|              | Sibling indicated error 1. Message from the destination=
 host:  |
> +|              | operation failed: job 'migration in' failed: load of mi=
gration |
> +|              | failed: No such device: Failed to load vmstate version_=
id: 1,  |
> +|              | ret: -19                                               =
        |
> ++--------------+--------------------------------------------------------=
--------+
> +
> +**Destinaton host**

[Severity: Low]
This isn't a bug, but there is a typo in the word "Destinaton".

> +
> ++--------------+--------------------------------------------------------=
--------+
> +| Kernel log:  | vfio_ap_mdev $UUID: Queue $APID.$APQI not available to =
        |
> +|              | vfio_ap driver on target host                          =
        |
> ++--------------+--------------------------------------------------------=
--------+
> +| QEMU log:    | shutting down, reason=3Dfailed                         =
          |
> +|              | qemu-system-s390x: terminating on signal $SIGNAL_NUM fr=
om      |
> +|              | pid $PID $DAEMON                                       =
        |
> ++--------------+--------------------------------------------------------=
--------+

[ ... ]

> +**Destination host**
> +
> ++--------------+--------------------------------------------------------=
--------+
> +| Log          | Message                                                =
        |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> +| Console log: | vfio_ap_mdev $UUID: migration failed: Failed to get hwi=
nfo for |
> +|              | queue $APQN on target host: rc=3D$RESPONSE-CODE"       =
          |

[Severity: Low]
This isn't a bug, but there appears to be an unmatched trailing quote=20
character at the end of the rc=3D$RESPONSE-CODE string.

> ++--------------+--------------------------------------------------------=
--------+
> +| QEMU log:    | shutting down, reason=3Dfailed                         =
          |
> +|              | qemu-system-s390x: terminating on signal $SIGNAL-ID fro=
m pid   |
> +|              | $PID $DAEMON                                           =
        |
> ++--------------+--------------------------------------------------------=
--------+
> +
> +.. note::
> +   * $UUID is the UUID of the mediated device being migrated from the so=
urce host.
> +   * $APQN (for example, 00.0033) of the queue device that is not compat=
ible.
> +   * $RESPONSE_CODE is the response code from the AP instruction.
> +   * $SIGNAL_NUM is the signal number of the signal that caused the QEMU=
 process
> +     to terminate.
> +   * $PID is the process ID of the QEMU process on the destination host.
> +   * $DAEMON is the name of the QEMU daemon process.
> +   * This message will be logged for each queue for which this error is =
detected.
> +
> +The AP configurations of the source guest and destination host not incom=
patible
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~

[Severity: Low]
Does this heading have a double negative?=20

The text below it enumerates failures when the configurations are not=20
compatible, but the heading says "not incompatible" which logically means
they are compatible.

> +The functional capabilities or facilities available on one or more of th=
e queues
> +passed through to the source guest are not compatible with the queue dev=
ice with
> +the same APQN on the destination system (see the Hardware Capabilities t=
able above)
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630104132.1598=
851-1-akrowiak@linux.ibm.com?part=3D15
