From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 11/15] target-s390x: New QMP command
	query-cpu-model
Date: Mon, 30 Mar 2015 14:20:43 -0600
Message-ID: <5519B01B.9010007@redhat.com>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>	<1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
	<20150330201721.GF7031@thinpad.lan.raisama.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PUFrRn8ATXBMOmSO0Gtrhd6DNqTH0P3Ai"
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20150330201721.GF7031@thinpad.lan.raisama.net>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eduardo Habkost <ehabkost@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PUFrRn8ATXBMOmSO0Gtrhd6DNqTH0P3Ai
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2015 02:17 PM, Eduardo Habkost wrote:
> On Mon, Mar 30, 2015 at 04:28:24PM +0200, Michael Mueller wrote:
>> This patch implements a new QMP request named 'query-cpu-model'.
>> It returns the cpu model of cpu 0 and its backing accelerator.
>>
>> request:
>>   {"execute" : "query-cpu-model" }
>>
>> answer:
>>   {"return" : {"name": "2827-ga2", "accel": "kvm" }}
>=20
> If you are returning information about an existing CPU, why not just
> extend the output of "query-cpus"?
>=20
> (Existing qmp_query_cpus() calls cpu_synchronize_state(), which may be
> undesired. But in this case we could add an optional parameter to
> disable the return of data that requires stopping the VCPU).

And how would libvirt learn about the existence of that optional
parameter?  Without introspection, a new command is easier to query than
learning about whether an optional parameter exists (then again, we're
hoping to get introspection into 2.4, so it may be a moot question).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PUFrRn8ATXBMOmSO0Gtrhd6DNqTH0P3Ai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJVGbAcAAoJEKeha0olJ0Nqmq8H/RJhMMOgOc1Hmpr8sWm5yYEi
r7eWCX9slWDowi5gDNzFRtEHlCT0H6BE8P6xECQO4felsGhmXwPtWGXQrs6HxVvH
eeLMP63AC8avpPDYDu+FxeqBMVBG/Ae4SvEoIUM7WMh9fdwYHLaMrTgkNUDqDaXB
pSNBv7DATe3Ws2Yy8Oz0NOuvbMg1ORAcZSMONFmwb4Q03NcQuNg+XHwj7lrxLQ1o
DzXwoP/FLHbtbCCaZd86h72q1Wg2rxN1U3O3bjhXUlFiCharAK2/Auni1ongfrfo
jtSxALU4+jBfx+fMyysEJyapHlVcWymhchmVaqLoIl/TSgMmoSJs7JnAuQhPEAc=
=Zj0v
-----END PGP SIGNATURE-----

--PUFrRn8ATXBMOmSO0Gtrhd6DNqTH0P3Ai--
