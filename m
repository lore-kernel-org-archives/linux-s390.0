Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 30 Nov 2020 09:55:49 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3] s390/pci: fix CPU address in MSI for directed IRQ
Message-ID: <20201130095549.27da927f.pasic@linux.ibm.com>
In-Reply-To: <2400bc6a-ff0a-f0b8-66fc-25e11032dacb@linux.ibm.com>
References: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
        <20201127095633.60f8a544.pasic@linux.ibm.com>
        <16fe9017-407f-1bb0-1599-fb46d93009fc@linux.ibm.com>
        <20201127163936.38a51c15.pasic@linux.ibm.com>
        <2400bc6a-ff0a-f0b8-66fc-25e11032dacb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 09:30:33 +0100
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> I'm not really familiar, with it but I think this is closely related
> to what I asked Bernd Nerz. I fear that if CPUs go away we might already
> be in trouble at the firmware/hardware/platform level because the CPU Add=
ress is
> "programmed into the device" so to speak. Thus a directed interrupt from
> a device may race with anything reordering/removing CPUs even if
> CPU addresses of dead CPUs are not reused and the mapping is stable.

=46rom your answer, I read that CPU hot-unplug is supported for LPAR.=20
>=20
> Furthermore our floating fallback path will try to send a SIGP
> to the target CPU which clearly doesn't work when that is permanently
> gone. Either way I think these issues are out of scope for this fix
> so I will go ahead and merge this.

I agree, it makes on sense to delay this fix.

But if CPU hot-unplug is supported, I believe we should react when
a CPU is unplugged, that is a target of directed interrupts. My guess
is, that in this scenario transient hiccups are unavoidable, and thus
should be accepted, but we should make sure that we recover.

Regards,
Halil
