From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v5 9/9] Documentation: virtual: kvm: Support vcpu
 preempted check
Date: Fri, 21 Oct 2016 09:23:48 +0800
Message-ID: <20161021012348.GC8429@tardis.cn.ibm.com>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com, bsingharora@gmail.com, borntraeger@de.ibm.com, rkrcmar@redhat.com
List-ID: <linux-s390.vger.kernel.org>


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2016 at 05:27:54PM -0400, Pan Xinhui wrote:
> Commit ("x86, kvm: support vcpu preempted check") add one field "__u8
> preempted" into struct kvm_steal_time. This field tells if one vcpu is
> running or not.
>=20
> It is zero if 1) some old KVM deos not support this filed. 2) the vcpu is
> preempted. Other values means the vcpu has been preempted.
  ^^^^^^^^^
s/preempted/not preempted

And better to fix other typos in the commit log ;-)
Maybe you can try aspell? That works for me.

Regards,
Boqun

>=20
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  Documentation/virtual/kvm/msr.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/virtual/kvm/msr.txt b/Documentation/virtual/kv=
m/msr.txt
> index 2a71c8f..3376f13 100644
> --- a/Documentation/virtual/kvm/msr.txt
> +++ b/Documentation/virtual/kvm/msr.txt
> @@ -208,7 +208,8 @@ MSR_KVM_STEAL_TIME: 0x4b564d03
>  		__u64 steal;
>  		__u32 version;
>  		__u32 flags;
> -		__u32 pad[12];
> +		__u8  preempted;
> +		__u32 pad[11];
>  	}
> =20
>  	whose data will be filled in by the hypervisor periodically. Only one
> @@ -232,6 +233,11 @@ MSR_KVM_STEAL_TIME: 0x4b564d03
>  		nanoseconds. Time during which the vcpu is idle, will not be
>  		reported as steal time.
> =20
> +		preempted: indicate the VCPU who owns this struct is running or
> +		not. Non-zero values mean the VCPU has been preempted. Zero
> +		means the VCPU is not preempted. NOTE, it is always zero if the
> +		the hypervisor doesn't support this field.
> +
>  MSR_KVM_EOI_EN: 0x4b564d04
>  	data: Bit 0 is 1 when PV end of interrupt is enabled on the vcpu; 0
>  	when disabled.  Bit 1 is reserved and must be zero.  When PV end of
> --=20
> 2.4.11
>=20

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYCW4fAAoJEEl56MO1B/q4XjoH/iDXtnuULj1M8FCfNTkaHBp2
znvPhAOvkvOZiOf87FTk/l7c4sxf6eaEu0qIfj/oCWIzP0jGed4oqzDvPpOz8+nj
dP/9sZbX5aeAix0JOrM93IwA9eNc4QkHR1m1qR6EQPhbq0Aq9Aj2SAcpPrLvqyxb
FAgPHU7As4X9fVW89WnDfeL1jF0DwDcjGZ6EUMRUiRawBXDGR2axyl5j9ITEHlkK
se19SIZipqMjbjXrrcc+LiNrVFANL2qZvr2C3Tgk+La27yIk4hxwJ3Y6PW9EdvoJ
BN2EeDIpksXsQPW6i7Maf4qtHO7C4E1k1Gm9C2KnBO+seAgNzF2BkIA+xk/oZfo=
=TkuH
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--
