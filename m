From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v1 RFC 09/10] QEMU: s390: cpu model QMP
	query-cpu-model
Date: Tue, 13 May 2014 09:29:37 -0600
Message-ID: <53723A61.4020601@redhat.com>
References: <1399993222-16339-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1399993222-16339-10-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oh9VwbwkUM0iwPL7Ie6cxfo4E6tjX6AHW"
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1399993222-16339-10-git-send-email-mimu@linux.vnet.ibm.com>
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
To: Michael Mueller <mimu@linux.vnet.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oh9VwbwkUM0iwPL7Ie6cxfo4E6tjX6AHW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/13/2014 09:00 AM, Michael Mueller wrote:
> This patch implements a new QMP request named "query-cpu-model". It ret=
urns
> the cpu model of cpu 0. eg:
>=20
> request: '{"execute" : "query-cpu-model" }
> answer:  '{"return" : {"name": "2827-ga2"}}
>=20
> Alias names are resolved to their respective machine type and GA names
> already during cpu instantiation. Thus, also a cpu name like "host",
> which is implemented as alias, will return its normalized cpu model nam=
e.
>=20

> +    }
> +    cpu_model =3D g_try_malloc0(sizeof(*cpu_model));

It's simpler to just use g_malloc0 and rely on glibc's exit-on-OOM
behavior than to try and deal with NULL - this isn't user input (so
unlikely to be so huge as to cause OOM), and would be more in line with
what most other QMP code does.  But that said...

> +    if (!cpu_model) {
> +        goto out_no_mem;
> +    }
> +    cpu_model->name =3D g_try_malloc0(CPU_MODEL_NAME_LEN);
> +    if (!cpu_model->name) {
> +        goto out_no_mem;
> +    }
> +    snprintf(cpu_model->name, CPU_MODEL_NAME_LEN - 1, "%04x-ga%u",
> +             cc->proc->type, cc->mach->ga);

=2E..why not just use g_strdup_printf() instead of trying to size a buffe=
r
yourself?  In other words, skip the g_try_malloc0 to begin with.

The fact that you are packing two pieces of information into one string
is a bit worrisome - that means that the client of the QMP command has
to parse the string back into two pieces of information if they ever
need either item in isolation.  If the user never has a need to split
the name down into parts, you are okay; I don't know S390 well enough to
know whether anyone will care about type separate from ga.  But if
someone DOES care, then the QMP command should return the parts already
split, as in { "type": 2827, "ga": 2 }, or even as convenience provide
both split and combined forms: { "name": "2827-ga2", "type": 2827, "ga": =
2 }

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--oh9VwbwkUM0iwPL7Ie6cxfo4E6tjX6AHW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJTcjpiAAoJEKeha0olJ0NqnqAH/A6ztyI9nzH1EOf/s5Yee37D
jyRuVXqSoNuzppMo8k+8sqSk0ViMsD0jTgK5fI21WFpAWXWK0wfL1//E0ai8lUXZ
jO8s2/Zzg/9CrIDlkJ3kVdCD+st7/Jf6R4ArSn1fk/hL7Z9ARW4PiH6q1IWPXYxL
eQ4coAP4LenLJOkE4WhxgfLd2SCPVKB8W+hGil+OVZFBRlBNGIx1eiU1Tb4aq3Bx
9hJCcB4zoaakzSZhtci/D0yokZJKWyq97GZFAkHVan/sxyIN3LlkwDBq64C5zl8R
RFaB0M1lodptG3FhLESkcvuyNv64/Lf8bzBzjNNAxKFwSS+qVp+0HNw/djXeqn8=
=+08T
-----END PGP SIGNATURE-----

--oh9VwbwkUM0iwPL7Ie6cxfo4E6tjX6AHW--
